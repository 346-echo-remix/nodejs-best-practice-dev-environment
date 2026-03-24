VM Performance & DX Optimizations

Running a VM can sometimes lead to file-watching bottlenecks or memory issues.
Increase Watcher Limits

Linux has a limit on how many files it can "watch" at once. Large Next.js projects with many dependencies can hit this limit, causing the dev server to crash.
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
Resource Monitoring

Install htop or btop to monitor if your Node processes are "ballooning" in memory.
sudo apt install htop
The .env Strategy

Never hardcode secrets. Use .env.local for your VM-specific environment variables. Next.js loads these automatically.
