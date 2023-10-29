---
title: Predicting Political Parties from Text
summary: Based on the transcript of a parliamentary speech, can we predict which party the speaker belongs to?
date: '2022-02-07T00:00:00Z'

# Optional external URL for project (replaces project detail page).
external_link: ''

image:
  focal_point: Smart

url_code: 'https://github.com/timweiland/bundestag_party_prediction/'
url_pdf: 'https://github.com/timweiland/bundestag_party_prediction/blob/master/reports/project.pdf'
url_slides: ''
url_video: ''

---

Joint work with Mattia Masiero. This was our final project for the Data Literacy course at the University of Tübingen in WS21/22.

If I hand you the transcript of a political speech held in the German Bundestag, can you guess which party the speaker belongs to? We explore different techniques to build a classifier that takes a transcript and predicts a political party. In the end, we obtain a fair classifier that achieves $\approx 50$% accuracy, which is three times better than pure guessing. The classifier is fair in the sense that there are no large margins in prediction performance between large and small parties.

If you're interested in these kinds of analyses, [you may also be interested in this blog post on tf-idf.](/post/finding-important-words/finding_important_words/)
