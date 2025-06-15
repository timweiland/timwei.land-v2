---
title: 'Scaling up Probabilistic PDE Simulators with Structured Volumetric Information'
authors:
  - Tim Weiland
  - Marvin Pförtner
  - Philipp Hennig

# Optional URLs for co-authors (omit authors you don't want to link)
author_urls:
  - name: "Tim Weiland"
    url: "https://timwei.land"
  - name: "Marvin Pförtner"
    url: "https://uni-tuebingen.de/en/fakultaeten/mathematisch-naturwissenschaftliche-fakultaet/fachbereiche/informatik/lehrstuehle/methoden-des-maschinellen-lernens/personen/marvin-pfoertner/"
  - name: "Philipp Hennig"
    url: "https://uni-tuebingen.de/en/fakultaeten/mathematisch-naturwissenschaftliche-fakultaet/fachbereiche/informatik/lehrstuehle/methoden-des-maschinellen-lernens/personen/prof-dr-philipp-hennig/"

date: '2024-06-07T00:00:00Z'
doi: '10.48550/arXiv.2406.05020'

# Schedule page publish date (NOT publication's date).
publishDate: '2024-06-07T00:00:00Z'

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ['3']

# Publication name and optional abbreviated publication name.
publication: 'arXiv preprint'
publication_short: 'arXiv'

abstract: 'Modeling real-world problems with partial differential equations (PDEs) is a prominent topic in scientific machine learning. Classic solvers for this task continue to play a central role, e.g. to generate training data for deep learning analogues. Any such numerical solution is subject to multiple sources of uncertainty, both from limited computational resources and limited data (including unknown parameters). Gaussian process analogues to classic PDE simulation methods have recently emerged as a framework to construct fully probabilistic estimates of all these types of uncertainty. So far, much of this work focused on theoretical foundations, and as such is not particularly data efficient or scalable. Here we propose a framework combining a discretization scheme based on the popular Finite Volume Method with complementary numerical linear algebra techniques. Practical experiments, including a spatiotemporal tsunami simulation, demonstrate substantially improved scaling behavior of this approach over previous collocation-based techniques.'

# Summary. An optional shortened abstract.
summary: 'Introduces GP-FVM, a probabilistic counterpart to the finite volume method, enabling large-scale probabilistic PDE simulations.'

tags:
  - Physics-Informed ML
  - PDEs
  - Bayesian Inference
  - Numerical Analysis

# Display this page in the Featured widget?
featured: true

# Custom links (uncomment lines below)
# links:
# - name: Custom Link
#   url: http://example.org

url_pdf: 'https://arxiv.org/pdf/2406.05020.pdf'
url_code: 'https://github.com/timweiland/gp-fvm'
url_dataset: ''
url_poster: ''
url_project: ''
url_slides: ''
url_source: 'https://arxiv.org/abs/2406.05020'
url_video: ''

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
image:
  caption: 'Probabilistic PDE simulation framework'
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
