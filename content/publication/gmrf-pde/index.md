---
title: 'Flexible and Efficient Probabilistic PDE Solvers through Gaussian Markov Random Fields'
authors:
  - Tim Weiland
  - Marvin Pförtner
  - Philipp Hennig
  
author_urls:
  - name: "Marvin Pförtner"
    url: "https://marvinpfoertner.github.io"
  - name: "Philipp Hennig"
    url: "https://uni-tuebingen.de/fakultaeten/mathematisch-naturwissenschaftliche-fakultaet/fachbereiche/informatik/lehrstuehle/methoden-des-maschinellen-lernens/personen/philipp-hennig/"
date: '2025-04-23:00:00Z'
#doi: '10.1000/182'

# Schedule page publish date (NOT publication's date).
publishDate: '2025-04-23T00:00:00Z'

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ['1']

# Publication name and optional abbreviated publication name.
publication: 'In *Proceedings of the 28th International Conference on Artificial Intelligence and Statistics (AISTATS)*'
publication_short: 'In *AISTATS*'

abstract: 'Mechanistic knowledge about the physical world is virtually always expressed via partial differential equations (PDEs). Recently, there has been a surge of interest in probabilistic PDE solvers—Bayesian statistical models mostly based on Gaussian process (GP) priors which seamlessly combine empirical measurements and mechanistic knowledge. As such, they quantify uncertainties arising from e.g. noisy or missing data, unknown PDE parameters or discretization error by design. Prior work has established connections to classical PDE solvers and provided solid theoretical guarantees. However, scaling such methods to large-scale problems remains a challenge, primarily due to dense covariance matrices. Our approach addresses the scalability issues by leveraging the Markov property of many commonly used GP priors. It has been shown that such priors are solutions to stochastic PDEs (SPDEs), which, when discretized, allow for highly efficient GP regression through sparse linear algebra. In this work, we show how to leverage this prior class to make probabilistic PDE solvers practical, even for large-scale nonlinear PDEs, through greatly accelerated inference mechanisms. Additionally, our approach also allows for flexible and physically meaningful priors beyond what can be modeled with covariance functions. Experiments confirm substantial speedups and accelerated convergence of our physics-informed priors in nonlinear settings.'

# Summary. An optional shortened abstract.
summary: 'Fast probabilistic counterparts to numerical PDE solvers, powered by SPDEs & sparse linear algebra.'

tags:
  - Physics-Informed ML
  - PDEs
  - Bayesian Inference
  - Sparse Linear Algebra

# Display this page in the Featured widget?
featured: true

# Custom links (uncomment lines below)
# links:
# - name: Custom Link
#   url: http://example.org

url_source: 'https://proceedings.mlr.press/v258/weiland25a.html'
url_pdf: 'https://raw.githubusercontent.com/mlresearch/v258/main/assets/weiland25a/weiland25a.pdf'
url_code: 'https://github.com/timweiland/DiffEqGMRFs.jl'
url_dataset: ''
url_poster: ''
url_project: ''
url_slides: ''
url_video: ''

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
image:
  caption: 'Research methodology overview'
  focal_point: ''
  preview_only: false

# Associated Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter your project's folder name, e.g. `internal-project`.
#   Otherwise, set `projects: []`.
projects: []

# Slides (optional).
#   Associate this publication with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides: "example"` references `content/slides/example/index.md`.
#   Otherwise, set `slides: ""`.
slides: ""
---

