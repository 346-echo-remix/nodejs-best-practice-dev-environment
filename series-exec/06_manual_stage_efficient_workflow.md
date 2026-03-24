Secure & Efficient Workflow

    Git Integration: Always use SSH keys for your GitHub/GitLab connections from the VM rather than HTTPS to avoid repeated password prompts.

    Process Management: For "always-on" dev previews or internal tools, use PM2.
    pnpm add -g pm2
    pm2 start npm --name "my-app" -- run dev

    Housekeeping: Periodically run pnpm store prune to clear out unused package versions from your VM storage.
