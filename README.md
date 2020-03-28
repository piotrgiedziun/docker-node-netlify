# CI/CD node + netlify base image

## Gitlab CI/CD

```yaml
stages:
  - deploy

review:
  stage: deploy
  image: node:13-stretch-slim
  script:
    - yarn install
    - yarn build
    - DYNAMIC_ENVIRONMENT_URL=$(netlify deploy --site $NETLIFY_SITE_ID --auth $NETLIFY_AUTH_TOKEN --json | jq -r ".deploy_url")
    - echo "DYNAMIC_ENVIRONMENT_URL=$DYNAMIC_ENVIRONMENT_URL" >> deploy.env 
  artifacts:
    reports:
      dotenv: deploy.env
  environment:
    name: review/$CI_COMMIT_REF_SLUG
    url: $DYNAMIC_ENVIRONMENT_URL
    on_stop: stop_review
    auto_stop_in: 1 week
  only:
   - branches

stop_review:
  stage: deploy
  script:
    - echo "nothing to do"
  when: manual
  environment:
    name: review/$CI_COMMIT_REF_SLUG
    action: stop
```