# tmca.classify
R package for proportional classification and active learning

## Experiment example demos

Two experiments are provided:

1. Sentiment Analysis: `demo(active_learning_sentiments)`
2. Party Manifestos: `demo(active_learning_manifestos)`

The first experiment conducts repeated active learning of sentiment classes to learn about stability of the process and influence of parameters (e.g. initial training size).

The second experiment conducts active learning of party manifesto categories. It employs ngram features and LDA features. Feature extraction may take a while depending on your hardware. Performance of the process is evaluated by predicting category proportions in party manifestos correctly.

For details about the example data, see the README in the data folder.

## Usage example

To conduct an own active learning, here is some example code:

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

Since gold labels for the example data are known, we can compare predicted and true proportions for the different review sources (Yelp, Amazon, Imdb).