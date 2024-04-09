#### graphical representation of phase 1 of the Population neuroscience project #####
##Jolly, March 2024

# Load required libraries
library(ggplot2)
library(tidyr)
library(dplyr)

#entire database of the 21 sites preprocess
database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
database_counts <- database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
database_counts$name <- factor(database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("ABCD, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals
# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/ABCD_all_sites.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")


#individual database for each site
#G010
G010_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/G010_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
G010_database_counts <- G010_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
G010_database_counts$name <- factor(G010_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(G010_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("G010, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = G010_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- G010_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/G010.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#G031
G031_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/G031_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
G031_database_counts <- G031_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
G031_database_counts$name <- factor(G031_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(G031_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("G031, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = G031_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- G031_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/G031.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#G032
G032_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/G032_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
G032_database_counts <- G032_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
G032_database_counts$name <- factor(G032_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(G032_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("G032, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = G032_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- G032_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/G032.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#G075
G075_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/G075_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
G075_database_counts <- G075_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
G075_database_counts$name <- factor(G075_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(G075_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("G075, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = G075_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- G075_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/G075.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#G087
G087_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/G087_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
G087_database_counts <- G087_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
G087_database_counts$name <- factor(G087_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(G087_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("G087, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = G087_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- G087_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/G087.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#S011
S011_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/S011_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
S011_database_counts <- S011_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
S011_database_counts$name <- factor(S011_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(S011_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("S011, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = S011_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- S011_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/S011.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#S012
S012_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/S012_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
S012_database_counts <- S012_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
S012_database_counts$name <- factor(S012_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(S012_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("S012, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = S012_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- S012_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/S012.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#S014
S014_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/S014_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
S014_database_counts <- S014_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
S014_database_counts$name <- factor(S014_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(S014_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("S014, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = S014_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- S014_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/S014.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#S020
S020_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/S020_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
S020_database_counts <- S020_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
S020_database_counts$name <- factor(S020_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(S020_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("S020, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = S020_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- S020_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/S020.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#S021
S021_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/S021_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
S021_database_counts <- S021_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
S021_database_counts$name <- factor(S021_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(S021_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("S021, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = S021_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- S021_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/S021.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#S022
S022_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/S022_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
S022_database_counts <- S022_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
S022_database_counts$name <- factor(S022_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(S022_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("S022, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = S022_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- S022_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/S022.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#S042
S042_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/S042_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
S042_database_counts <- S042_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
S042_database_counts$name <- factor(S042_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(S042_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("S042, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = S042_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- S042_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/S042.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#S053
S053_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/S053_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
S053_database_counts <- S053_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
S053_database_counts$name <- factor(S053_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(S053_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("S053, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = S053_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- S053_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/S053.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#S065
S065_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/S065_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
S065_database_counts <- S065_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
S065_database_counts$name <- factor(S065_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(S065_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("S065, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = S065_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- S065_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/S065.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#S076
S076_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/S076_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
S076_database_counts <- S076_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
S076_database_counts$name <- factor(S076_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(S076_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("S076, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = S076_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- S076_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/S076.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#S086
S086_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/S086_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
S086_database_counts <- S086_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
S086_database_counts$name <- factor(S086_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(S086_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("S086, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = S086_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- S086_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/S086.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#S090
S090_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/S090_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
S090_database_counts <- S090_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
S090_database_counts$name <- factor(S090_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(S090_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("S090, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = S090_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- S090_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/S090.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#S013
S013_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/S013_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
S013_database_counts <- S013_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
S013_database_counts$name <- factor(S013_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(S013_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("S013, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = S013_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- S013_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/S013.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")


#P064
P064_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/P064_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
P064_database_counts <- P064_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
P064_database_counts$name <- factor(P064_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(P064_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("P064, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = P064_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- P064_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/P064.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#P043
P043_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/P043_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
P043_database_counts <- P043_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
P043_database_counts$name <- factor(P043_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(P043_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("P043, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = P043_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- P043_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/P043.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")

#P023
P023_database <- read.delim('/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/P023_database.txt')

# Define the desired order of column names
desired_order <- c("Download.0.", "DataSufficiency.1.", "dcm2bids.2.", "MRIQC.3.", "fMRIprep.4.")

# Calculate the counts for each status
P023_database_counts <- P023_database %>%
  pivot_longer(-Subject.IDs) %>%
  group_by(name, value) %>%
  summarise(count = n()) %>%
  arrange(name, value)

# Convert the column name to a factor with the desired levels
P023_database_counts$name <- factor(P023_database_counts$name, levels = desired_order)

# Create the stacked bar plot
plot <- ggplot(P023_database_counts, aes(x = name, y = count, fill = value)) +
  geom_bar(stat = "identity") +
  labs(x = "Pipeline Steps", y = "Number of Subjects", fill = "Status") +
  scale_fill_manual(values = c("Success" = "green4", "ERROR" = "red", "N/A" = "gray", "ERROR(1.1)" = "blue",
                               "ERROR(1.2)" = "deepskyblue", "ERROR(1.3)" = "yellow"),
                    labels = c("Success" = "Success", "ERROR" = "ERROR", "N/A" = "Processing not executed", 
                               "ERROR(1.1)" = "Missing T1", "ERROR(1.2)" = "Missing resting-state", 
                               "ERROR(1.3)" = "Missing both")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("P023, Phase 1: Preprocessing")  # Add title here

# Add text labels with counts next to the legend
plot_with_counts <- plot +
  geom_text(data = P023_database_counts, aes(label = count), 
            position = position_stack(vjust = 0.5), size = 3, color = "black")

# Create a separate text box with the total counts for each status
total_counts <- P023_database_counts %>%
  group_by(value) %>%
  summarise(total_count = sum(count)) %>%
  arrange(value)

# Add a text box with the total counts
plot_with_counts_with_totals <- plot_with_counts +
  geom_text(data = total_counts, aes(label = paste(value, ": ", total_count)), 
            x = 0.4, y = 0.85, hjust = 1, vjust = 1,
            size = 3, color = "black", show.legend = FALSE)

plot_with_counts_with_totals

# Save the plot as a PNG file with a specified width and height
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/P023.png", plot_with_counts_with_totals, width = 8, height = 8, dpi = 300,
       bg = "white")



##################

###DVARS and FD######

#G010
library(tidyverse)

# Directory containing the .tsv files
directory <- "/Users/ashmeetjolly/Desktop/G010_tsv"

# List all .tsv files in the directory
tsv_files <- list.files(directory, pattern = "\\.tsv$", full.names = TRUE)

# Initialize empty lists to store subject IDs, DVARS, and FD values
subject_ids <- c()
dvars_values <- c()
fd_values <- c()

# Loop through each .tsv file
for (tsv_file in tsv_files) {
  # Extract subject ID from the file name
  subject_id <- gsub(".*sub-(\\w+)_ses.*", "\\1", basename(tsv_file))
  
  # Read .tsv file
  data <- read.delim(tsv_file, header = TRUE, sep = "\t")
  
  # Replace "n/a" with NA
  data$dvars <- gsub("n/a", NA, data$dvars)
  data$framewise_displacement <- gsub("n/a", NA, data$framewise_displacement)
  
  # Convert 'dvars' and 'framewise_displacement' to numeric
  data$dvars <- as.numeric(data$dvars)
  data$framewise_displacement <- as.numeric(data$framewise_displacement)
  
  # Calculate average DVARS and FD values for the current file
  avg_dvars <- mean(data$dvars, na.rm = TRUE)
  avg_fd <- mean(data$framewise_displacement, na.rm = TRUE)
  
  # Append subject ID, average DVARS, and average FD values to lists
  subject_ids <- c(subject_ids, subject_id)
  dvars_values <- c(dvars_values, avg_dvars)
  fd_values <- c(fd_values, avg_fd)
}

# Compute overall averages
overall_avg_dvars <- mean(dvars_values, na.rm = TRUE)
overall_avg_fd <- mean(fd_values, na.rm = TRUE)

# Create histograms
library(ggplot2)

# Create a data frame for DVARS and FD values, removing missing values
dvars_data <- data.frame(value = na.omit(dvars_values))
fd_data <- data.frame(value = na.omit(fd_values))

# Create histograms for DVARS and FD values separately
plot_dvars <- ggplot() +
  geom_histogram(data = dvars_data, aes(x = value), binwidth = 1, fill = "lightblue", color = "black") +
  labs(title = "G010 Average DVARS Values", x = "Average DVARS", y = "Number of subjects") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(limits = c(0, 50)) +
  geom_vline(xintercept = overall_avg_dvars, color = "red", linetype = "dashed")

plot_fd <- ggplot() +
  geom_histogram(data = fd_data, aes(x = value), binwidth = 0.05, fill = "lightgreen", color = "black") +
  labs(title = "G010 Average FD Values", x = "Average FD", y = "Number of subjects") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(limits = c(0, 1)) +
  geom_vline(xintercept = overall_avg_fd, color = "red", linetype = "dashed")

# Print histograms
print(plot_dvars)
print(plot_fd)

# Create a data frame with subject IDs, mean DVARS, and mean FD values
G010_subject_data <- data.frame(
  Subject_ID = subject_ids,
  Mean_DVARS = dvars_values,
  Mean_FD = fd_values
)


suppressWarnings(ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/G010_dvars.png", plot_dvars, width = 8, height = 8, dpi = 300, bg = "white"))
suppressWarnings(ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/G010_fd.png", plot_fd, width = 8, height = 8, dpi = 300, bg = "white"))

#save the mean dvars and fd data
write.csv(G010_subject_data, "/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/G010_dvars_fd.csv", row.names = FALSE)

#P064

library(tidyverse)

# Directory containing the .tsv files
directory <- "/Users/ashmeetjolly/Desktop/P064_tsv"

# List all .tsv files in the directory
tsv_files <- list.files(directory, pattern = "\\.tsv$", full.names = TRUE)

# Initialize empty lists to store subject IDs, DVARS, and FD values
subject_ids <- c()
dvars_values <- c()
fd_values <- c()

# Loop through each .tsv file
for (tsv_file in tsv_files) {
  # Extract subject ID from the file name
  subject_id <- gsub(".*sub-(\\w+)_ses.*", "\\1", basename(tsv_file))
  
  # Read .tsv file
  data <- read.delim(tsv_file, header = TRUE, sep = "\t")
  
  # Replace "n/a" with NA
  data$dvars <- gsub("n/a", NA, data$dvars)
  data$framewise_displacement <- gsub("n/a", NA, data$framewise_displacement)
  
  # Convert 'dvars' and 'framewise_displacement' to numeric
  data$dvars <- as.numeric(data$dvars)
  data$framewise_displacement <- as.numeric(data$framewise_displacement)
  
  # Calculate average DVARS and FD values for the current file
  avg_dvars <- mean(data$dvars, na.rm = TRUE)
  avg_fd <- mean(data$framewise_displacement, na.rm = TRUE)
  
  # Append subject ID, average DVARS, and average FD values to lists
  subject_ids <- c(subject_ids, subject_id)
  dvars_values <- c(dvars_values, avg_dvars)
  fd_values <- c(fd_values, avg_fd)
}

# Compute overall averages
overall_avg_dvars <- mean(dvars_values, na.rm = TRUE)
overall_avg_fd <- mean(fd_values, na.rm = TRUE)

# Create histograms
library(ggplot2)

# Create a data frame for DVARS and FD values, removing missing values
dvars_data <- data.frame(value = na.omit(dvars_values))
fd_data <- data.frame(value = na.omit(fd_values))

# Create histograms for DVARS and FD values separately
plot_dvars <- ggplot() +
  geom_histogram(data = dvars_data, aes(x = value), binwidth = 1, fill = "lightblue", color = "black") +
  labs(title = "P064 Average DVARS Values", x = "Average DVARS", y = "Number of subjects") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(limits = c(0, 50)) +
  geom_vline(xintercept = overall_avg_dvars, color = "red", linetype = "dashed")

plot_fd <- ggplot() +
  geom_histogram(data = fd_data, aes(x = value), binwidth = 0.05, fill = "lightgreen", color = "black") +
  labs(title = "P064 Average FD Values", x = "Average FD", y = "Number of subjects") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(limits = c(0, 1)) +
  geom_vline(xintercept = overall_avg_fd, color = "red", linetype = "dashed")

# Print histograms
print(plot_dvars)
print(plot_fd)

# Create a data frame with subject IDs, mean DVARS, and mean FD values
P064_subject_data <- data.frame(
  Subject_ID = subject_ids,
  Mean_DVARS = dvars_values,
  Mean_FD = fd_values
)

suppressWarnings(ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/P064_dvars.png", plot_dvars, width = 8, height = 8, dpi = 300, bg = "white"))
suppressWarnings(ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/P064_fd.png", plot_fd, width = 8, height = 8, dpi = 300, bg = "white"))

#save the mean dvars and fd data
write.table(P064_subject_data, "/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/P064_dvars_fd.tsv", sep = "\t", row.names = FALSE)

#S013

library(tidyverse)

# Directory containing the .tsv files
directory <- "/Users/ashmeetjolly/Desktop/S013_tsv"

# List all .tsv files in the directory
tsv_files <- list.files(directory, pattern = "\\.tsv$", full.names = TRUE)

# Initialize empty lists to store subject IDs, DVARS, and FD values
subject_ids <- c()
dvars_values <- c()
fd_values <- c()

# Loop through each .tsv file
for (tsv_file in tsv_files) {
  # Extract subject ID from the file name
  subject_id <- gsub(".*sub-(\\w+)_ses.*", "\\1", basename(tsv_file))
  
  # Read .tsv file
  data <- read.delim(tsv_file, header = TRUE, sep = "\t")
  
  # Replace "n/a" with NA
  data$dvars <- gsub("n/a", NA, data$dvars)
  data$framewise_displacement <- gsub("n/a", NA, data$framewise_displacement)
  
  # Convert 'dvars' and 'framewise_displacement' to numeric
  data$dvars <- as.numeric(data$dvars)
  data$framewise_displacement <- as.numeric(data$framewise_displacement)
  
  # Calculate average DVARS and FD values for the current file
  avg_dvars <- mean(data$dvars, na.rm = TRUE)
  avg_fd <- mean(data$framewise_displacement, na.rm = TRUE)
  
  # Append subject ID, average DVARS, and average FD values to lists
  subject_ids <- c(subject_ids, subject_id)
  dvars_values <- c(dvars_values, avg_dvars)
  fd_values <- c(fd_values, avg_fd)
}

# Compute overall averages
overall_avg_dvars <- mean(dvars_values, na.rm = TRUE)
overall_avg_fd <- mean(fd_values, na.rm = TRUE)

# Create histograms
library(ggplot2)

# Create a data frame for DVARS and FD values, removing missing values
dvars_data <- data.frame(value = na.omit(dvars_values))
fd_data <- data.frame(value = na.omit(fd_values))

# Create histograms for DVARS and FD values separately
plot_dvars <- ggplot() +
  geom_histogram(data = dvars_data, aes(x = value), binwidth = 1, fill = "lightblue", color = "black") +
  labs(title = "S013 Average DVARS Values", x = "Average DVARS", y = "Number of subjects") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(limits = c(0, 50)) +
  geom_vline(xintercept = overall_avg_dvars, color = "red", linetype = "dashed")

plot_fd <- ggplot() +
  geom_histogram(data = fd_data, aes(x = value), binwidth = 0.05, fill = "lightgreen", color = "black") +
  labs(title = "S013 Average FD Values", x = "Average FD", y = "Number of subjects") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(limits = c(0, 1)) +
  geom_vline(xintercept = overall_avg_fd, color = "red", linetype = "dashed")

# Print histograms
print(plot_dvars)
print(plot_fd)

# Create a data frame with subject IDs, mean DVARS, and mean FD values
S013_subject_data <- data.frame(
  Subject_ID = subject_ids,
  Mean_DVARS = dvars_values,
  Mean_FD = fd_values
)

suppressWarnings(ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/S013_dvars.png", plot_dvars, width = 8, height = 8, dpi = 300, bg = "white"))
suppressWarnings(ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/S013_fd.png", plot_fd, width = 8, height = 8, dpi = 300, bg = "white"))

#save the mean dvars and fd data
write.table(S013_subject_data, "/Users/ashmeetjolly/Desktop/ABCD_data/Status_files/S013_dvars_fd.tsv", sep = "\t", row.names = FALSE)

#stacked histogram

# Add dataset labels to each dataframe
G010_subject_data$Dataset <- "G010"
P064_subject_data$Dataset <- "P064"
S013_subject_data$Dataset <- "S013"

# Combine the datasets
combined_data <- rbind(G010_subject_data, P064_subject_data, S013_subject_data)

# Create stacked histograms for average DVARS values for each dataset
stacked_plot_dvars <- ggplot(combined_data, aes(x = Mean_DVARS, fill = Dataset)) +
  geom_histogram(binwidth = 1, alpha = 0.5, position = "stack") +
  labs(title = "Average DVARS Values of the 3 sites", x = "Average DVARS", y = "Number of subjects") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(values = c("G010" = "lightblue", "P064" = "lightgreen", "S013" = "lightcoral" )) + 
  scale_x_continuous(limits = c(0, 50))

# Create stacked histograms for average FD values for each dataset
stacked_plot_fd <- ggplot(combined_data, aes(x = Mean_FD, fill = Dataset)) +
  geom_histogram(binwidth = 0.05, alpha = 0.5, position = "stack") +
  labs(title = "Average FD Values of the 3 sites", x = "Average FD", y = "Number of subjects") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(values = c("G010" = "lightblue", "P064" = "lightgreen", "S013" = "lightcoral")) +
  scale_x_continuous(limits = c(0, 1))


# Print stacked histograms
print(stacked_plot_dvars)
print(stacked_plot_fd)

suppressWarnings(ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/stacked_plots_dvars.png", stacked_plot_dvars, width = 8, height = 8, dpi = 300, bg = "white"))
suppressWarnings(ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/stacked_plots_fd.png", stacked_plot_fd, width = 8, height = 8, dpi = 300, bg = "white"))

####MRIQC SNR and CNR####
#G010

# Load the jsonlite package
library(jsonlite)

#for T1
# Directory containing the .json files
directory <- "/Users/ashmeetjolly/Desktop/G010_anat_CNR_tSNR"

# List all .json files in the directory
json_files <- list.files(directory, pattern = "\\.json$", full.names = TRUE)

# Initialize an empty list to store subject IDs and CNR values
subject_cnr <- list()
subject_snr_total <- list()

# Loop through each .json file
for (json_file in json_files) {
  # Read the JSON file
  json_data <- fromJSON(json_file)
  
  # Extract subject ID from the file name
  subject_id <- gsub(".*sub-(\\w+)_ses.*", "\\1", basename(json_file))
  
  # Extract CNR value from the JSON data
  cnr_value <- json_data$cnr
  
  # Extract SNR Total value from the JSON data
  snr_total_value <- json_data$snr_total
  
  # Store subject ID, CNR value, and SNR Total value in the lists
  subject_cnr[[subject_id]] <- cnr_value
  subject_snr_total[[subject_id]] <- snr_total_value
}

# Convert the lists to data frames
G010_cnr_data <- data.frame(
  CNR = unlist(subject_cnr)
)

G010_snr_total_data_T1 <- data.frame(
  SNR_Total = unlist(subject_snr_total)
)

#Plotting the T1 cnr and snr
library(ggplot2)

# Histogram for CNR values
G010_histogram_cnr <- ggplot(G010_cnr_data, aes(x = CNR)) +
  geom_histogram(binwidth = 0.1, fill = "lightblue", color = "black") +
  labs(title = "G010 CNR Values", x = "CNR", y = "Number of subjects") +
  theme_minimal()

# Histogram for SNR Total values
G010_histogram_snr_T1 <- ggplot(G010_snr_total_data_T1, aes(x = SNR_Total)) +
  geom_histogram(binwidth = 0.1, fill = "lightgreen", color = "black") +
  labs(title = "G010 T1 SNR_total Values", x = "SNR Total", y = "Number of subjects") +
  theme_minimal()

# Print the histograms
print(G010_histogram_cnr)
print(G010_histogram_snr_T1)

library(gridExtra)
# Arrange plots in a grid
G010_T1_SNR_CNR <- grid.arrange(G010_histogram_cnr, G010_histogram_snr_T1, ncol = 2)

#saving the plot 
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/G010_T1_SNR_CNR.png", G010_T1_SNR_CNR , width = 8, height = 8, dpi = 300, bg = "white")


#for functional SNR
# Load the jsonlite package
library(jsonlite)

# Directory containing the .json files
directory <- "//Users/ashmeetjolly/Desktop/G010_func_SNR"

# List all .json files in the directory
json_files <- list.files(directory, pattern = "\\.json$", full.names = TRUE)

# Initialize an empty list to store subject IDs and CNR values
subject_snr <- list()

# Loop through each .json file
for (json_file in json_files) {
  # Read the JSON file
  json_data <- fromJSON(json_file)
  
  # Extract subject ID from the file name
  subject_id <- gsub(".*sub-(\\w+)_ses.*", "\\1", basename(json_file))
  
  # Extract CNR value from the JSON data
  snr_value <- json_data$snr
  
  # Store subject ID and CNR value in the list
  subject_snr[[subject_id]] <- snr_value
}

# Convert the list to a data frame
G010_snr_data_rs <- data.frame(
  SNR = unlist(subject_snr)
)

# Histogram for SNR rs values
G010_histogram_snr_rs <- ggplot(G010_snr_data_rs, aes(x = SNR)) +
  geom_histogram(binwidth = 0.1, fill = "lightgreen", color = "black") +
  labs(title = "G010 resting state SNR Values", x = "SNR", y = "Number of subjects") +
  theme_minimal()

print(G010_histogram_snr_rs)

#saving the plot 
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/G010_rs_SNR.png", G010_histogram_snr_rs , width = 8, height = 8, dpi = 300, bg = "white")

#P064
# Load the jsonlite package
library(jsonlite)

#for T1
# Directory containing the .json files
directory <- "/Users/ashmeetjolly/Desktop/P064_anat_CNR_tSNR"

# List all .json files in the directory
json_files <- list.files(directory, pattern = "\\.json$", full.names = TRUE)

# Initialize an empty list to store subject IDs and CNR values
subject_cnr <- list()
subject_snr_total <- list()

# Loop through each .json file
for (json_file in json_files) {
  # Read the JSON file
  json_data <- fromJSON(json_file)
  
  # Extract subject ID from the file name
  subject_id <- gsub(".*sub-(\\w+)_ses.*", "\\1", basename(json_file))
  
  # Extract CNR value from the JSON data
  cnr_value <- json_data$cnr
  
  # Extract SNR Total value from the JSON data
  snr_total_value <- json_data$snr_total
  
  # Store subject ID, CNR value, and SNR Total value in the lists
  subject_cnr[[subject_id]] <- cnr_value
  subject_snr_total[[subject_id]] <- snr_total_value
}

# Convert the lists to data frames
P064_cnr_data <- data.frame(
  CNR = unlist(subject_cnr)
)

P064_snr_total_data_T1 <- data.frame(
  SNR_Total = unlist(subject_snr_total)
)

#Plotting the T1 cnr and snr
library(ggplot2)

# Histogram for CNR values
P064_histogram_cnr <- ggplot(P064_cnr_data, aes(x = CNR)) +
  geom_histogram(binwidth = 0.1, fill = "lightblue", color = "black") +
  labs(title = "P064 CNR Values", x = "CNR", y = "Number of subjects") +
  theme_minimal()

# Histogram for SNR Total values
P064_histogram_snr_T1 <- ggplot(P064_snr_total_data_T1, aes(x = SNR_Total)) +
  geom_histogram(binwidth = 0.1, fill = "lightgreen", color = "black") +
  labs(title = "P064 T1 SNR_total Values", x = "SNR Total", y = "Number of subjects") +
  theme_minimal()

# Print the histograms
print(P064_histogram_cnr)
print(P064_histogram_snr_T1)

library(gridExtra)
# Arrange plots in a grid
P064_T1_SNR_CNR <- grid.arrange(P064_histogram_cnr, P064_histogram_snr_T1, ncol = 2)

#saving the plot 
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/P064_T1_SNR_CNR.png", P064_T1_SNR_CNR , width = 8, height = 8, dpi = 300, bg = "white")


#for functional SNR
# Load the jsonlite package
library(jsonlite)

# Directory containing the .json files
directory <- "//Users/ashmeetjolly/Desktop/P064_func_SNR"

# List all .json files in the directory
json_files <- list.files(directory, pattern = "\\.json$", full.names = TRUE)

# Initialize an empty list to store subject IDs and CNR values
subject_snr <- list()

# Loop through each .json file
for (json_file in json_files) {
  # Read the JSON file
  json_data <- fromJSON(json_file)
  
  # Extract subject ID from the file name
  subject_id <- gsub(".*sub-(\\w+)_ses.*", "\\1", basename(json_file))
  
  # Extract CNR value from the JSON data
  snr_value <- json_data$snr
  
  # Store subject ID and CNR value in the list
  subject_snr[[subject_id]] <- snr_value
}

# Convert the list to a data frame
P064_snr_data_rs <- data.frame(
  SNR = unlist(subject_snr)
)

# Histogram for SNR rs values
P064_histogram_snr_rs <- ggplot(P064_snr_data_rs, aes(x = SNR)) +
  geom_histogram(binwidth = 0.1, fill = "lightgreen", color = "black") +
  labs(title = "P064 resting state SNR Values", x = "SNR", y = "Number of subjects") +
  theme_minimal()

print(P064_histogram_snr_rs)

#saving the plot 
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/P064_rs_SNR.png", P064_histogram_snr_rs , width = 8, height = 8, dpi = 300, bg = "white")

#S013
# Load the jsonlite package
library(jsonlite)

#for T1
# Directory containing the .json files
directory <- "/Users/ashmeetjolly/Desktop/S013_anat_CNR_tSNR"

# List all .json files in the directory
json_files <- list.files(directory, pattern = "\\.json$", full.names = TRUE)

# Initialize an empty list to store subject IDs and CNR values
subject_cnr <- list()
subject_snr_total <- list()

# Loop through each .json file
for (json_file in json_files) {
  # Read the JSON file
  json_data <- fromJSON(json_file)
  
  # Extract subject ID from the file name
  subject_id <- gsub(".*sub-(\\w+)_ses.*", "\\1", basename(json_file))
  
  # Extract CNR value from the JSON data
  cnr_value <- json_data$cnr
  
  # Extract SNR Total value from the JSON data
  snr_total_value <- json_data$snr_total
  
  # Store subject ID, CNR value, and SNR Total value in the lists
  subject_cnr[[subject_id]] <- cnr_value
  subject_snr_total[[subject_id]] <- snr_total_value
}

# Convert the lists to data frames
S013_cnr_data <- data.frame(
  CNR = unlist(subject_cnr)
)

S013_snr_total_data_T1 <- data.frame(
  SNR_Total = unlist(subject_snr_total)
)

#Plotting the T1 cnr and snr
library(ggplot2)

# Histogram for CNR values
S013_histogram_cnr <- ggplot(S013_cnr_data, aes(x = CNR)) +
  geom_histogram(binwidth = 0.1, fill = "lightblue", color = "black") +
  labs(title = "S013 CNR Values", x = "CNR", y = "Number of subjects") +
  theme_minimal()

# Histogram for SNR Total values
S013_histogram_snr_T1 <- ggplot(S013_snr_total_data_T1, aes(x = SNR_Total)) +
  geom_histogram(binwidth = 0.1, fill = "lightgreen", color = "black") +
  labs(title = "S013 T1 SNR_total Values", x = "SNR Total", y = "Number of subjects") +
  theme_minimal()

# Print the histograms
print(S013_histogram_cnr)
print(S013_histogram_snr_T1)

library(gridExtra)
# Arrange plots in a grid
S013_T1_SNR_CNR <- grid.arrange(S013_histogram_cnr, S013_histogram_snr_T1, ncol = 2)

#saving the plot 
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/S013_T1_SNR_CNR.png", S013_T1_SNR_CNR , width = 8, height = 8, dpi = 300, bg = "white")


#for functional SNR
# Load the jsonlite package
library(jsonlite)

# Directory containing the .json files
directory <- "//Users/ashmeetjolly/Desktop/S013_func_SNR"

# List all .json files in the directory
json_files <- list.files(directory, pattern = "\\.json$", full.names = TRUE)

# Initialize an empty list to store subject IDs and CNR values
subject_snr <- list()

# Loop through each .json file
for (json_file in json_files) {
  # Read the JSON file
  json_data <- fromJSON(json_file)
  
  # Extract subject ID from the file name
  subject_id <- gsub(".*sub-(\\w+)_ses.*", "\\1", basename(json_file))
  
  # Extract CNR value from the JSON data
  snr_value <- json_data$snr
  
  # Store subject ID and CNR value in the list
  subject_snr[[subject_id]] <- snr_value
}

# Convert the list to a data frame
S013_snr_data_rs <- data.frame(
  SNR = unlist(subject_snr)
)

# Histogram for SNR rs values
S013_histogram_snr_rs <- ggplot(S013_snr_data_rs, aes(x = SNR)) +
  geom_histogram(binwidth = 0.1, fill = "lightgreen", color = "black") +
  labs(title = "S013 resting state SNR Values", x = "SNR", y = "Number of subjects") +
  theme_minimal()

print(S013_histogram_snr_rs)

#saving the plot 
ggsave("/Users/ashmeetjolly/Desktop/ABCD_data/Status_graphs/S013_rs_SNR.png", S013_histogram_snr_rs , width = 8, height = 8, dpi = 300, bg = "white")






