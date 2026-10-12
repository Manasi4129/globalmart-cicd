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
