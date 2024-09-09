#### graphical representation of phase 2 of the Population neuroscience project #####
##Jolly, September 2024

# Load required libraries
library(ggplot2)
library(tidyr)
library(dplyr)

#entire database of xcpd done on the 21 sites fmriprep data
database_post <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/database_xcpd.txt')

# Remove the last two columns of the xcpd database
database_post <- database_post %>%
  select(-ncol(database_post), -(ncol(database_post) - 1))

# Calculate the counts for each status
database_xcpd_counts <- database_post %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Create the stacked bar plot
plot <- ggplot(database_xcpd_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "Error(999)" = "red", "N/A" = "gray", "Error(1.1)" = "blue",
                               "Error(1.3)" = "deepskyblue", "Error(1.5)" = "yellow", "Error(1.6)" = "brown3",
                    "Error(2.1)" = "lightslateblue", "Error(2.3)" = "sienna1"),
                    labels = c("Success" = "Success", "Error(999)" = "Unknown Error", "N/A" = "Processing not executed", 
                               "Error(1.1)" = "IndexError: list index out of range", "Error(1.2)" = "(sqlite3.OperationalError) database or disk is full", 
                               "Error(1.3)" = "dataset_description.json file not found", "Error(1.5)"="dataset with < 15 time points per voxel",
                               "Error(1.6)" = "AssertionError: 207 != 208", "Error(2.1)" = "IndexError: list index out of range",
                               "Error(2.3)" = "dataset_description.json file not found")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("ABCD, Phase 2: Postprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = database_xcpd_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- database_xcpd_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals



###test####

# Load required libraries
library(ggplot2)
library(tidyr)
library(dplyr)

# Load the datasets
database_pre <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/database.txt')
database_post <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/database_xcpd.txt')

# Remove the last two columns of the postprocessing dataset
database_post <- database_post %>%
  select(-ncol(database_post), -(ncol(database_post) - 1))

# Define the desired order of column names for both preprocessing and postprocessing stages
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.",
                   "xcp_d.36P._cifti.1.", "xcp_d.36P._noncifti.2.")

# Combine the datasets
combined_data <- database_pre %>%
  select(Subject.IDs, matches("Download|DataSufficiency|dcm2bids|MRIQC|fMRIprep")) %>%
  full_join(database_post %>% select(Subject.IDs, matches("xcp_d")), by = "Subject.IDs")

# Calculate the counts for each status
combined_counts <- combined_data %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n(), .groups = 'drop') %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
combined_counts$name <- factor(combined_counts$name, levels = desired_order)

# Define custom colors
custom_colors <- c("Success" = "green4", "N/A" = "slategray2",
                   "Error(1.1)" = "blue", "Error(1.2)" = "deepskyblue", 
                   "Error(1.3)" = "yellow4", "Error(1.5)" = "yellow",
                   "Error(1.6)" = "brown3", "Error(2.1)" = "lightslateblue", 
                   "Error(2.3)" = "sienna1", "Error(999)" = "red", "ERROR" = "palevioletred", "N/A" = "gray", "ERROR(1.1)" = "pink",
                   "ERROR(1.2)" = "plum", "ERROR(1.3)" = "sandybrown")

# Create the stacked bar plot
plot <- ggplot(combined_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Processing Stages", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = custom_colors, 
                    labels = c("Success" = "Success", "Error(999)" = "xcp_d Unknown Error", "N/A" = "Processing not executed", 
                               "Error(1.1)" = "IndexError: list index out of range", "Error(1.2)" = "(sqlite3.OperationalError) database or disk is full", 
                               "Error(1.3)" = "dataset_description.json file not found", "Error(1.5)"="dataset with < 15 time points per voxel",
                               "Error(1.6)" = "AssertionError: 207 != 208", "Error(2.1)" = "IndexError: list index out of range",
                               "Error(2.3)" = "dataset_description.json file not found", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  scale_x_discrete(labels = c("Download.0." = "Download", 
                              "DataSufficiency.1." = "Data Sufficiency", 
                              "dcm2bids.2." = "dcm2bids", 
                              "MRIQC.3." = "MRIQC", 
                              "fMRIprep.4." = "fMRIprep",
                              "xcp_d.36P._cifti.1." = "xcp_d_36P(CIFTI)", 
                              "xcp_d.36P._noncifti.2." = "xcp_d_36P(non-CIFTI)")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("ABCD Baseline data: Preprocessing and Postprocessing")

# Add text labels with counts within the bars
plot_with_counts <- plot +
  geom_text(data = combined_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 4, color = "black")

# Show the plot
print(plot_with_counts)

# Specify the file path and name for the output
output_file <- "/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/combined_prepost_plot.png"

# Save the plot with specified dimensions and resolution
ggsave(output_file, plot = plot_with_counts, width = 14, height = 10, dpi = 300, bg = "white")
