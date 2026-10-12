# GlobalMart E-Commerce: CI/CD Pipeline on AWS

Every push to 'main' is automatically deployed to a live EC2 web server, with no manual steps.

```
GitHub (main) → AWS CodePipeline → AWS CodeDeploy → EC2 (Amazon Linux 2023 + Apache)
```

## How it works
- **GitHub**: source code for the GlobalMart storefront ('app/')
- **CodePipeline (V2)**: detects each commit and starts a release
- **CodeDeploy**: copies the site onto the server and runs the lifecycle scripts in 'appspec.yml"
- **EC2**: serves the site; it's found by CodeDeploy using the tag 'Environment=GlobalMart-Prod'
- **IAM roles**: separate least-privilege roles for EC2, CodeDeploy and CodePipeline

## Deployment lifecycle (appspec.yml)
| Hook | Script | Purpose |
|---|---|---|
| ApplicationStop | 'stop_server.sh' | Stop Apache safely before files change |
| BeforeInstall | 'install_dependencies.sh' | Make sure Apache is installed |
| ApplicationStart | 'start_server.sh' | Start Apache |
| ValidateService | 'validate_service.sh' | Health check: fail the deployment unless the site serves the GlobalMart page |

## Troubleshooting practised
- Broke the health check on purpose, then traced the failure through CodeDeploy lifecycle events and the agent logs
- Diagnosed common issues: tag mismatch (0 instances), agent/IAM role problems, GitHub connection status

## Tech
AWS EC2 · CodePipeline · CodeDeploy · IAM · Systems Manager · GitHub · Bash · Apache

## Screenshots
Successful CodePipeline
<img width="1182" height="521" alt="CodePipeline" src="https://github.com/user-attachments/assets/e24bba76-7404-4585-a535-2aa5c579d30d" />

Deployment History | Made changes to app file to check deployments were successful
<img width="1627" height="431" alt="CodeDeployHistory" src="https://github.com/user-attachments/assets/74d1faf9-a6e9-4503-ba4b-cc490573dd29" />

Errors | validate script was changed
<img width="1102" height="475" alt="ErrorLogs" src="https://github.com/user-attachments/assets/e83da68e-81fd-4ba0-9e11-3a100f602aa3" />

Succssful Deploy and Final o/p
<img width="1110" height="601" alt="image" src="https://github.com/user-attachments/assets/685d0d99-cecf-46d5-b810-a82c6090b6f9" />
<img width="1916" height="653" alt="image" src="https://github.com/user-attachments/assets/262679ae-87e0-4211-bd36-204993303974" />




