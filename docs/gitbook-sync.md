# GitBook Sync

Use GitBook Git Sync to publish this folder as the documentation site.

## Recommended Setup

1. Create a GitBook space.
2. Choose **Set up Git Sync**.
3. Install the GitBook GitHub app.
4. Select the `ihkaz/BetterDisblox` repository.
5. Select the `main` branch.
6. Select the `docs/` folder as the synced content folder.
7. Use GitHub to GitBook sync if you want the repository to stay as the source of truth.
8. Publish the GitBook space.

## Editing Flow

Edit Markdown files in `docs/`, commit the changes, and push to `main`.

GitBook will pull the updated Markdown content through Git Sync.

## Navigation

`SUMMARY.md` defines the initial page order for GitBook-style imports and keeps the docs structure readable in GitHub.
