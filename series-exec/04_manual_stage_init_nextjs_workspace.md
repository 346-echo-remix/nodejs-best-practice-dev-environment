Initializing your Next.js Workspace

When creating your project, leverage the App Router and Turbopack (the Rust-based successor to Webpack) for the best development experience.

pnpm create next-app@latest my-project

### 🛠️ Recommended Next.js Setup Settings (2026)

| Prompt | Recommendation | Why? |
| :--- | :--- | :--- |
| **TypeScript** | Yes | Essential for 2026 type safety and autocompletion. |
| **ESLint** | Yes | Keeps code clean and catches common errors. |
| **Tailwind CSS** | Yes | Industry standard for rapid, scalable UI. |
| **src/ directory** | Yes | Keeps your root folder clean of config files. |
| **App Router** | Yes | Required for Server Components and modern data fetching. |
| **Turbopack** | Yes | Significantly faster HMR (Hot Module Replacement). |

> **Pro Tip:** Use `pnpm create next-app@latest` to trigger these prompts in your Debian VM.
