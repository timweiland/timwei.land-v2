# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

This is a personal portfolio website built with Hugo using the Hugo Academic Theme (now Hugo Blox Builder). The site showcases academic work, projects, and blog posts.

### Key Structure
- **Hugo Static Site Generator**: Uses Hugo v0.119.0 with Go modules for theme management
- **Hugo Blox Builder**: Modern academic theme with modules for Netlify integration and reveal.js presentations
- **Content Organization**: Structured around authors, posts, projects, publications, and events
- **Asset Management**: Images and media files are processed through Hugo's imaging pipeline with automatic resizing and optimization

### Configuration
- Main config in `config/_default/` directory with YAML files for different aspects (config, menus, params, languages)
- Netlify deployment configured with build optimization and caching
- Go modules manage theme dependencies through `go.mod`

## Common Commands

### Development
```bash
hugo server              # Start development server with live reload
hugo server -D           # Include draft content
hugo server --buildFuture # Include future-dated content
```

### Build
```bash
hugo                     # Build static site to public/ directory
hugo --gc --minify      # Build with garbage collection and minification (production)
hugo --buildFuture      # Build including future-dated content
```

### Content Management
```bash
hugo new post/my-post/index.md              # Create new blog post
hugo new project/my-project/index.md        # Create new project
hugo new publication/my-paper/index.md      # Create new publication
```

### Asset Generation
```bash
# Generate icons from base icon.jpg (requires ImageMagick)
cd assets/media && ./generate-icons.sh
```

### Deployment
Site deploys automatically to Netlify when pushed to main branch. Local testing uses the same build command as production: `hugo --gc --minify`.