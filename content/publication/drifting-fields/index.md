---
title: 'Drifting Fields are not Conservative'
authors:
  - Leonard T. Franz
  - Sebastian Hoffmann
  - Tim Weiland
  - Bernhard Schölkopf
  - Georg Martius

# Optional URLs for co-authors (omit authors you don't want to link)
author_urls:
  - name: "Tim Weiland"
    url: "https://timwei.land"

date: '2026-04-07T00:00:00Z'
doi: '10.48550/arXiv.2604.06333'

# Schedule page publish date (NOT publication's date).
publishDate: '2026-04-07T00:00:00Z'

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ['3']

# Publication name and optional abbreviated publication name.
publication: 'arXiv preprint'
publication_short: 'arXiv'

abstract: 'Drifting models have recently gained attention for generating high-quality samples in a single forward pass. During training, they learn a push-forward map by following a vector-valued field, the drift field. We ask whether this procedure is equivalent to optimizing a scalar loss and find that, in general, it is not: drift fields are not conservative and cannot be written as the gradient of any scalar potential. We identify the position-dependent normalization as the source of non-conservatism, with the Gaussian kernel as the unique radial exception. Guided by this, we introduce the sharp kernel k^# and a sharp-normalized drift field that is conservative for general radial kernels. The resulting vector field is the gradient of a scalar potential that can be optimized directly using stochastic gradient descent. Moreover, the field has the form of a score difference of kernel density estimates, and gives exact equilibrium identifiability. Thus, sharp normalization closes the gap to related literature, such as Wasserstein gradient-flows and denoising score matching, also for non-Gaussian kernels. Empirically, sharp normalization preserves the performance of the original drifting objective, suggesting that the non-conservative flexibility is not required for high-quality generation.'

# Summary. An optional shortened abstract.
summary: 'Drift fields in generative models are generally non-conservative; sharp normalization makes them gradients of a scalar potential, bridging to Wasserstein gradient flows and denoising score matching.'

tags:
  - Generative Models
  - Machine Learning
  - Score Matching

# Display this page in the Featured widget?
featured: false

# Custom links (uncomment lines below)
# links:
# - name: Custom Link
#   url: http://example.org

url_pdf: 'https://arxiv.org/pdf/2604.06333'
url_code: ''
url_dataset: ''
url_poster: ''
url_project: ''
url_slides: ''
url_source: 'https://arxiv.org/abs/2604.06333'
url_video: ''

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
image:
  caption: ''
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
