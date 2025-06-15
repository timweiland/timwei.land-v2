+++
title = "Finding Important Words: tf-idf"
author = ["Tim Weiland"]
date = 2021-04-18
tags = ["statistics", "machine_learning", "nlp"]
summary = "Learn how tf-idf combines term frequency and inverse document frequency to identify the most important words in a document by balancing local relevance with global rarity."
draft = false
+++

## Not all words are created equal {#not-all-words-are-created-equal}

Here is our premise. We have a coherent sequence of words thought up by a human, for instance a book, an essay, a blog post such as this one, or a transcription of a speech. We would now like to find the most important words within that sequence.

But what does "important" mean? It's an ambiguous term, but clearly there is some notion of importance that everybody can agree upon. Words such as "a" or "the" are not very important. They are necessary because English grammar demands that we use them, but if you removed all instances of "a" or "the" in a book, you would still be able to follow the plot perfectly fine. (In fact many languages, for instance Chinese, Korean and Japanese, don't even have articles such as "a" or "the".) Other words are significantly more important - imagine you deleted all occurences of the words "vector" and "matrix" in a Linear Algebra textbook.

Intuitively, one might identify two components regarding the importance of a word:

1.  **How often does the word appear in the document**? Naturally, words that are strongly related to the topic of the document will appear repeatedly. For example a book about World War II will have many occurences of the word "Hitler".
2.  **How often does the word appear in any document in general?** The less documents a word appears in, the more interesting it should be. The word "the" appears in almost all English documents, and we do not care about it. But words such as "NASA" or "Fourier" or "convolution" appear in extremely few documents! (This certainly requires that your document corpus covers a wide range of topics; if your corpus only consists of scientific papers these words will be a lot more common.)

Criterion 1 measures the distinction of a word within one specific document (more common = more important), while criterion 2 measures the distinction of a word across all possible documents (more common = less important). The combination of both leads to a pretty good measure of word importance. The statistic that implements these two criteria is called **tf-idf**.


## Criterion 1: Term Frequency (tf) {#criterion-1-term-frequency--tf}

The term frequency is the frequency of a particular word (term) in a particular document. If \\(n\_{d}(t)\\) is the number of occurences of term \\(t\\) in document \\(d\\) and \\(\mid d \mid\\) is the total number of words in \\(d\\), then the term frequency \\(tf(t, d)\\) is defined as

\begin{equation}
\text{tf}(t, d) = \frac{n\_{d}(t)}{\mid d \mid}
\end{equation}

In the document \\(d = \text{"I like bananas. Bananas are yellow. Bananas are crescent-shaped."}\\), we have \\(\text{tf}(\text{"bananas"}, d) = 3/9\\), \\(\text{tf}(\text{"are"}, d) = 2/9\\) and \\(\text{tf}(t', d) = 1/9\\) for any other term \\(t'\\). If we used only the term frequency as a measure of importance, notice how "are" would be more important than "crescent-shaped". That doesn't seem right - criterion 1 on its own doesn't cut it.


## Criterion 2: Inverse Document Frequency (idf) {#criterion-2-inverse-document-frequency--idf}

For the inverse document frequency, we want to know how informative a term is across all documents.

Let's take a quick excursion to information theory. It will help us appreciate the idf definition. In information theory, an event is more informative the more surprising it is. If we execute an experiment with random outcomes, we can define for each event \\(E\_i\\) with probability \\(p\_i\\):

\begin{equation}
I(E\_i) = \log \left( \frac{1}{p\_{i}} \right) = - \log p\_i
\end{equation}

We call this the **self-information** of \\(E\_i\\). The information slowly tends towards \\(+ \infty\\) for events with very low probabilities, and approaches \\(0\\) as events become more probable. This is pretty intuitive. Imagine you take a walk and afterwards proudly proclaim to your friends "Today, I **didn't** find $1000 laying on the ground!" - your friends wouldn't be surprised at all, because it's extremely rare to find that much money on the ground. If you **did** find that money however, your friends would be very surprised!

This is exactly what we need to implement criterion 2! "Surprising" terms that rarely appear in a document should get a higher importance than common terms. Pick a document \\(d \in D\\) at random and define \\(E(t)\\) as the event that \\(t\\) occurs in \\(d\\) (this does not depend on the randomly picked \\(d\\)!). Then we can simply estimate the probability \\(p\_{t}\\) of \\(E(t)\\) via

\begin{equation}
p\_{t} = \frac{\mid \left\\{ d \in D: \hspace{0.2em} t \in D \right\\} \mid }{\mid D \mid}
\end{equation}

Plugging this into the equation for the self-information of \\(E(t, d)\\) finally leads us to the definition of the inverse document frequency:

\begin{equation}
\text{idf(t)} = I(E(t)) = \log \left( \frac{1}{p\_{t}} \right) = \log \left( \frac{\mid D \mid}{\mid \left\\{ d \in D: \hspace{0.2em} t \in D \right\\} \mid } \right)
\end{equation}


## Combining the two: tf-idf {#combining-the-two-tf-idf}

Finally, we can combine these two statistics into one to get an importance measure. We do this by simply multiplying the two:

\begin{equation}
\text{tfidf}(t, d) = \text{tf}(t, d) \cdot \text{idf}(t)
\end{equation}

Why the multiplication? Well, it's intuitive and it works well in practice. Information theory seems to be able to explain this too, though; I refer you to ([Aizawa 2003](#org9f9f99c)).


## Experimenting with TED talks {#experimenting-with-ted-talks}

Let's use tfidf to find important words in TED talks! I will use [this dataset on Kaggle](https://www.kaggle.com/rounakbanik/ted-talks) which contains data on TED Talks uploaded to the TED website until September 21st, 2017.

```shell
cd assets/ted
kaggle datasets download rounakbanik/ted-talks
unzip -o ted-talks.zip
```

The dataset provides two tables. `ted_main.csv` contains metadata:

```python
import pandas as pd

ted_main = pd.read_csv("assets/ted/ted_main.csv")
print(ted_main.loc[0])
```

```text
comments                                                           4553
description           Sir Ken Robinson makes an entertaining and pro...
duration                                                           1164
event                                                           TED2006
film_date                                                    1140825600
languages                                                            60
main_speaker                                               Ken Robinson
name                          Ken Robinson: Do schools kill creativity?
num_speaker                                                           1
published_date                                               1151367060
ratings               [{'id': 7, 'name': 'Funny', 'count': 19645}, {...
related_talks         [{'id': 865, 'hero': 'https://pe.tedcdn.com/im...
speaker_occupation                                      Author/educator
tags                  ['children', 'creativity', 'culture', 'dance',...
title                                       Do schools kill creativity?
url                   https://www.ted.com/talks/ken_robinson_says_sc...
views                                                          47227110
Name: 0, dtype: object
```

`transcripts.csv` contains the corresponding transcripts:

```python
transcripts = pd.read_csv("assets/ted/transcripts.csv")
print(transcripts.head())
```

```text
                                          transcript                                                url
0  Good morning. How are you?(Laughter)It's been ...  https://www.ted.com/talks/ken_robinson_says_sc...
1  Thank you so much, Chris. And it's truly a gre...  https://www.ted.com/talks/al_gore_on_averting_...
2  (Music: "The Sound of Silence," Simon & Garfun...  https://www.ted.com/talks/david_pogue_says_sim...
3  If you're here today — and I'm very happy that...  https://www.ted.com/talks/majora_carter_s_tale...
4  About 10 years ago, I took on the task to teac...  https://www.ted.com/talks/hans_rosling_shows_t...
```

We merge the two on the `url` column:

```python
ted = pd.merge(ted_main, transcripts, on='url')
ted['url'] = ted['url'].map(lambda url: url.strip())
```

Now, let's apply tfidf. Usually I'm fond of implementing algorithms on my own to develop a better understanding of them, but in this case the implementation is pretty straightforward and mostly mechanical, so I'll be lazy and use scikit-learn's implementation. As a neat little bonus, scikit-learn can remove stop words (extremely common words we don't care about, e.g. "the" and "a") for us before applying tfidf.

```python
from sklearn.feature_extraction.text import TfidfVectorizer
vectorizer = TfidfVectorizer(stop_words='english')
vectors = vectorizer.fit_transform(ted['transcript'])
print((type(vectors), vectors.shape))
```

```text
(<class 'scipy.sparse.csr.csr_matrix'>, (2467, 58489))
```

The result is a sparse matrix where entry \\((i, j)\\) contains the tfidf score of term \\(j\\) in talk \\(i\\). For ease of use, we'll turn it into a pandas dataframe:

```python
feature_names = vectorizer.get_feature_names()
dense = vectors.todense()
dense_list = dense.tolist()
tfidf = pd.DataFrame(dense_list, columns=feature_names)
print(tfidf.head())
```

```text
    00       000  0000  000000004  0000001  000001  00001  000042  0001  0009  000th  001  0015  003  004  004867  005  ...  être   ís  ñamu  önderoglu  ötzi  über  übernerd  ālep  čapek  ōfunato  ʾan  ʾilla  ʾilāha   อย  อยman   อร  送你葱
0  0.0  0.000000   0.0        0.0      0.0     0.0    0.0     0.0   0.0   0.0    0.0  0.0   0.0  0.0  0.0     0.0  0.0  ...   0.0  0.0   0.0        0.0   0.0   0.0       0.0   0.0    0.0      0.0  0.0    0.0     0.0  0.0    0.0  0.0  0.0
1  0.0  0.000000   0.0        0.0      0.0     0.0    0.0     0.0   0.0   0.0    0.0  0.0   0.0  0.0  0.0     0.0  0.0  ...   0.0  0.0   0.0        0.0   0.0   0.0       0.0   0.0    0.0      0.0  0.0    0.0     0.0  0.0    0.0  0.0  0.0
2  0.0  0.007860   0.0        0.0      0.0     0.0    0.0     0.0   0.0   0.0    0.0  0.0   0.0  0.0  0.0     0.0  0.0  ...   0.0  0.0   0.0        0.0   0.0   0.0       0.0   0.0    0.0      0.0  0.0    0.0     0.0  0.0    0.0  0.0  0.0
3  0.0  0.030868   0.0        0.0      0.0     0.0    0.0     0.0   0.0   0.0    0.0  0.0   0.0  0.0  0.0     0.0  0.0  ...   0.0  0.0   0.0        0.0   0.0   0.0       0.0   0.0    0.0      0.0  0.0    0.0     0.0  0.0    0.0  0.0  0.0
4  0.0  0.007940   0.0        0.0      0.0     0.0    0.0     0.0   0.0   0.0    0.0  0.0   0.0  0.0  0.0     0.0  0.0  ...   0.0  0.0   0.0        0.0   0.0   0.0       0.0   0.0    0.0      0.0  0.0    0.0     0.0  0.0    0.0  0.0  0.0

[5 rows x 58489 columns]
```

Let's use that to define two functions. First, we can get the top \\(k\\) keywords of a talk as follows:

```python
def get_top_k_keywords(talk_id, k):
    keywords = tfidf.loc[talk_id].sort_values(ascending=False)[:k]
    keywords = keywords[~(keywords==0)] # Filter out terms with tfidf score zero
    return keywords
```

We can also get a ranking of talks for a certain keyword (i.e. the first talk has the highest tfidf score for that term):

```python
def get_talks_with_keyword(keyword):
    if keyword not in tfidf:
        return None
    scores = tfidf[keyword].sort_values(ascending=False)
    scores = scores[~(scores == 0)]
    return scores
```

It's time to harvest the fruits of our labor. Let's find TED talks where the word "intelligence" is particularly important:

```python
with pd.option_context(
    "display.max_colwidth",
    None,
    "display.max_columns",
    5,
    "display.expand_frame_repr",
    False,
):
    talks = get_talks_with_keyword("intelligence")
    print(ted.loc[talks.index][["main_speaker", "title", "url"]][:5])
```

```text
            main_speaker                                                     title                                                                                             url
1593  Alex Wissner-Gross                           A new equation for intelligence                    https://www.ted.com/talks/alex_wissner_gross_a_new_equation_for_intelligence
2210          Sam Harris           Can we build AI without losing control over it?             https://www.ted.com/talks/sam_harris_can_we_build_ai_without_losing_control_over_it
1884        Nick Bostrom  What happens when our computers get smarter than we are?  https://www.ted.com/talks/nick_bostrom_what_happens_when_our_computers_get_smarter_than_we_are
1538      Mikko Hypponen     How the NSA betrayed the world's trust -- time to act     https://www.ted.com/talks/mikko_hypponen_how_the_nsa_betrayed_the_world_s_trust_time_to_act
2305         Grady Booch                            Don't fear superintelligent AI                              https://www.ted.com/talks/grady_booch_don_t_fear_superintelligence
```

That looks good! Three of these talks are about superintelligence, the one by Mikko Hypponen seems to be about intelligence in the context of espionage. I don't know what the one by Alex Wissner-Gross is about, so let's see if keywords can help us out:

```python
print(get_top_k_keywords(1593, 10))
```

```text
entropica       0.485239
intelligence    0.411859
maximize        0.241058
variety         0.133458
action          0.120513
entropy         0.116891
freedom         0.115266
threads         0.112236
future          0.110370
earth           0.109982
Name: 1593, dtype: float64
```

Having listened to the talk now, I can say that these keywords are pretty good. Wissner-Gross proposes that intelligence emerges from entropy, and that intelligence attempts to maximize future freedom of action. To test this theory, a software called Entropica has been developed.

Feel free to play around with this a bit more on your own: [here's a Jupyter Notebook I made](/code/ted_tfidf.ipynb).


## Conclusion {#conclusion}

From what I've tried out so far tfidf does a pretty good job, and it makes intuitive sense. Keep in mind that tfidf works best when you have a large document corpus that covers a wide range of topics. (Otherwise the idf component can't do its job right.) By default it also can't extract "key phrases" consisting of multiple words - e.g. "future freedom of action" would have been a nice key phrase for the Wissner-Gross talk. To achieve this with tfidf, you can calculate tfidf scores for n-grams (e.g. bigrams would extract key phrases consisting of two words).

There are lots of variations of tfidf, but there are also other keyword extraction algorithms, even ones that don't require the context of a document corpus; for example TextRank, RAKE and PositionRank. tfidf seems to get a lot of criticism for how it does not include semantic information, but I'm not sure how valid this statement is - I think semantics and word frequency in the sense of tfidf are correlated, so tfidf does actually indirectly capture information about semantics. But that's more of a personal intuition.


## Bibliography {#bibliography}

<a id="org9f9f99c"></a>Aizawa, Akiko. 2003. “An Information-Theoretic Perspective of Tf-Idf Measures.” _Inf. Process. Manag._
