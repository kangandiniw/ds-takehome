# validation.R - Validasi Statistik (Bagian C)

# Install package (jika belum ada)
# install.packages("ggplot2")
# install.packages("dplyr")
# install.packages("scales")
# install.packages("glmtoolbox")

# Load package
library(ggplot2)
library(dplyr)
library(scales)
library(glmtoolbox)

# Load data hasil prediksi dari Python
data <- read.csv("scoring_result.csv")

str(data)

# Fit model logistik dari probabilitas
model <- glm(true_default ~ predicted_prob, data = data, family = binomial)

# Hosmer-Lemeshow Test (g = 10 grup)
hl_result <- hltest(model, g = 10)
print("--- Hosmer-Lemeshow Test ---")
print(hl_result)

# Kalibrasi prediksi: Binning dan rata-rata
calib_data <- data %>%
  mutate(bin = ntile(predicted_prob, 10)) %>%
  group_by(bin) %>%
  summarise(
    avg_pred = mean(predicted_prob),
    avg_actual = mean(true_default)
  )

# Plot Kalibrasi
cal_plot <- ggplot(calib_data, aes(x = avg_pred, y = avg_actual)) +
  geom_line(color = "blue", linewidth = 1.5) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "gray") +
  scale_x_continuous(labels = percent_format(accuracy = 1)) +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    title = "Calibration Curve",
    x = "Predicted Default Probability",
    y = "Observed Default Rate"
  ) +
  theme_minimal()

# Menampilkan dan menyimpan grafik
print(cal_plot)
ggsave("calibration_curve.png", plot = cal_plot, width = 6, height = 4)

# Skor Kredit: Konversi dari probabilitas
score_card <- function(prob, min_score = 300, max_score = 850) {
  min_score + (max_score - min_score) * (1 - prob)
}

# Hitung skor & cut-off untuk default <= 5%
data$score <- score_card(data$predicted_prob)
threshold_score <- min(data$score[data$predicted_prob <= 0.05])

cat("\n--- Cut-off Score untuk Expected Default ≤ 5% ---\n")
print(threshold_score)
