library("tmca.classify")

# active learning examples for sentiments
data("sentiments")
corpus <- sentiment_data$SENTENCE
labels <- factor(rep(NA, length(corpus)), levels = c("Positive", "Negative"))
my_classification <- tmca_classify(corpus = corpus, labels = labels)
my_classification$create_initial_trainingset(50)
my_classification$active_learning(stop_threshold = 0.99, positive_class = "Positive", max_iterations = 10)
my_classification$plot_progress()
final_labels <- my_classification$classify()

# proportions
table(final_labels) / length(final_labels)
tmca_proportions(final_labels, sentiment_data$LABEL, facets = sentiment_data$SOURCE, positive_class = "Positive")
