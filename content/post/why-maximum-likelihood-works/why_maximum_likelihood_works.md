+++
title = "Why Maximum Likelihood works"
author = ["Tim Weiland"]
date = 2020-11-20
tags = ["statistics", "machine_learning"]
draft = false
+++

## Motivation {#motivation}

Let's say you have some data. You assume that this data comes from a specific probability distribution. You have an idea of what that distribution might be (e.g. Gaussian, Poisson, ...), but you don't know anything about its parameters. You would now like to use the data you have (which is a collection of **samples from that distribution**) to **estimate** either the parameters or some other property that depends on the parameters.

Time for an example. I'm bored and decide to find 50 undergraduate students on my college campus and ask them how old they are. Now I have 50 samples of an age distribution, and I'm going to assume that the age distribution is a normal distribution. That seems to be a fair assumption - most undergraduate students are of roughly the same age. Outliers (teenage students, students aged 30+) exist, but they are rare. Using my 50 samples, I would now like to estimate the mean and variance of the underlying normal distribution.

One method to achieve this goal is called **maximum likelihood estimation**. As the name implies, the idea is to choose the parameters such that the "probability" of our samples gets maximized. This _sounds_ pretty intuitive - we got the data we got, so its "probability" is probably not extremely low. If I had to pick between a set of parameters A which gives me a "probability" of 0.0001 and a set of parameters B which gives me a "probability" of 0.1 for my data, I would pick the latter. Note that maximum likelihood actually uses the density function instead of the probability function - using the probability function would be a bad idea for continuous distributions where the probability of a discrete point (i.e. a single sample) is zero.

But to me, this logic is still a bit fuzzy - I would like a more theoretically grounded explanation for why maximum likelihood estimation works. We'll get there, but first we need to learn about a very powerful idea: The **Kullback-Leibler divergence**.


## Kullback-Leibler divergence {#kullback-leibler-divergence}


### Definition {#definition}

The Kullback-Leibler divergence describes the "distance" between two probability distributions. Given two probability distributions \\(P\_{\vartheta\_0}\\) and \\(P\_{\vartheta\_1}\\) with parameters \\(\vartheta\_0\\) and \\(\vartheta\_1\\) and the corresponding density functions \\(f(x, \vartheta\_{0})\\) and \\(f(x, \vartheta\_{1})\\), the KL divergence is defined as

\begin{equation}
D(P\_{\vartheta\_0} \mid P\_{\vartheta\_1}) = \begin{cases} \int \log \left[ \frac{f(x, \vartheta\_0)}{f(x, \vartheta\_1)} \right] f(x, \vartheta\_0) dx &\text{ for continuous distributions} \\\\\\
\sum\_{x \in X} \log \left[ \frac{f(x, \vartheta\_0)}{f(x, \vartheta\_1)} \right] f(x, \vartheta\_0) &\text{ for discrete distributions }
\end{cases}
\end{equation}

Note that this is just an expected value, so we can also write

\begin{equation}
D(P\_{\vartheta\_0} \mid P\_{\vartheta\_1}) = \mathbb{E}\_{\vartheta\_{0}}\left[ \log  \frac{f(x, \vartheta\_0)}{f(x, \vartheta\_1)} \right]
\end{equation}


### Properties {#properties}

Cool. Now why is this so useful? Let's show some properties of the KL divergence. We're going to show these for the continuous case - the discrete case works exactly the same way.

Assume \\(\vartheta\_0 \neq \vartheta\_1\\). Then

\begin{align}
D(P\_{\vartheta\_0} \mid P\_{\vartheta\_1}) &= \int \log \left[ \frac{f(x, \vartheta\_0)}{f(x, \vartheta\_1)} \right] f(x, \vartheta\_0) dx \\\\\\
                                    &= \int - \log \left[ \frac{f(x, \vartheta\_1)}{f(x, \vartheta\_0)} \right] f(x, \vartheta\_0) dx \\\\\\
                                    &\overset{(\*)}{>} - \int \frac{f(x, \vartheta\_1)}{f(x, \vartheta\_0)} f(x, \vartheta\_0) dx + 1 \\\\\\
                                    &= 0 \\\\\\
\end{align}

where for (\*) we use \\(\log x < x - 1 \implies - \log x > -x + 1\\) (\\(x > 0, x \neq 1\\)). So if the parameters are not equal, the KL divergence is positive.

If the parameters are equal, then \\(\log \left[ \frac{f(x, \vartheta\_0)}{f(x, \vartheta\_1)} \right] = \log 1 = 0\\), and thus \\(D(P\_{\vartheta\_0} \mid P\_{\vartheta\_1}) = 0\\).

In summary, we have

1.  \\(D(P\_{\vartheta\_0} \mid P\_{\vartheta\_1}) \geq 0 \quad \forall \vartheta\_{0}, \vartheta\_{1}\\)
2.  \\(D(P\_{\vartheta\_0} \mid P\_{\vartheta\_1}) = 0 \Leftrightarrow \vartheta\_{0} = \vartheta\_{1}\\)

The avid topologist might notice that we are only lacking symmetry and the triangle inequality to have a metric. Unfortunately, another quick look at the definition of the KL divergence reveals that it is not symmetric in general, and [a bit more thought](https://math.stackexchange.com/questions/1359195/is-there-a-counterexample-that-shows-that-the-kl-divergence-does-not-satisfy-the) reveals that it also does not fulfill the triangle inequality.


## Finding the true parameters with Kullback and Leibler {#finding-the-true-parameters-with-kullback-and-leibler}

So we don't have a metric - but that's okay, because these two properties are already incredibly useful. Remember our goal: We have a distribution with some true parameters (let's gather them in a vector and call it \\(\vartheta\_{0}\\)) and we want to calculate some estimated parameters (gather these in a vector as well and call it \\(\vartheta\_1\\)) that are as "close" to the true parameters as possible. And that's where the KL divergence comes to the rescue:

\begin{align}
&\vartheta\_{0} \neq \vartheta\_{1} \\\\\\
\Leftrightarrow \quad &D(P\_{\vartheta\_0} \mid P\_{\vartheta\_1}) > 0 \\\\\\
\Leftrightarrow \quad &\mathbb{E}\_{\vartheta\_0}\left[ \log \frac{f(x, \vartheta\_0)}{f(x, \vartheta\_1)} \right] > 0\\\\\\
\Leftrightarrow \quad &\mathbb{E}\_{\vartheta\_0}\left[ \log f(x, \vartheta\_0) - \log f(x, \vartheta\_1) \right] > 0 \\\\\\
\Leftrightarrow \quad &\mathbb{E}\_{\vartheta\_0}\left[ \log f(x, \vartheta\_0) \right] > \mathbb{E}\_{\vartheta\_0}\left[ \log f(x, \vartheta\_1) \right]
\end{align}

This is crucial. This tells us that the true parameters are the ones that maximize the function \\(\vartheta \mapsto \mathbb{E}\_{\vartheta\_0}\left[ \log f(x, \vartheta) \right]\\). You probably see the connection to the maximum likelihood estimate already, but don't get too excited just yet - there is one more thing we need to look out for. We need to take the expected value with respect to \\(\vartheta\_0\\), but \\(\vartheta\_0\\) is exactly what we're trying to find in the first place!

Fortunately, we have the very aptly named **law of large numbers** to save us. Let \\(\left( X\_{i} \right)\_{i} \, (i \in \mathbb{N})\\) be a sequence of independently, identically distributed random variables. Then the law of big numbers tells us

\begin{equation}
P\left(\lim\_{n \to \infty} \frac{1}{n} \sum\_{i=1}^{n} X\_{i} = \mathbb{E} X\_{1}\right) = 1
\end{equation}

In other words: We can approximate expected values by the mean using a large sample size. The more samples we have, the better our approximation will be. (Technically, this might not hold for some samples, but in practice that's not going to happen because the probability for those samples is zero.)

Thus, we can approximate \\(\vartheta \mapsto \mathbb{E}\_{\vartheta\_0}\left[ \log f(x, \vartheta) \right]\\) with \\(\vartheta \mapsto \frac{1}{n} \sum\_{n = 1}^{n} \log f(x, \vartheta)\\). Constant coefficients don't matter when we're optimizing functions, so let's just maximize \\(\vartheta \mapsto \sum\_{n = 1}^{n} \log f(x, \vartheta)\\). And there you have it - that's exactly the **log likelihood** function. And if for some reason you don't care much for log likelihood, note that you can simply apply \\(\exp(x)\\), again without changing the maximum(s), and obtain the regular likelihood function.


## Wrapping it up {#wrapping-it-up}

From the properties of the KL divergence, we learned that we can find the true parameters of a distribution by maximizing the expected value of the log density (as a function of the parameters). Since calculating the expected value would require knowledge of the true parameters in the first place, we instead used the law of large numbers to our advantage by replacing the expected value with a mean over our samples. Cleaning the resulting function up a bit, we ended up with the maximum likelihood estimation method. We also learned that the more samples we have, the better the maximum likelihood estimate will be.

I hope that this insight gave you some newfound appreciation for the maximum likelihood method, a fundamental tool of statistics.
