<div align="center">
<img src="https://user-images.githubusercontent.com/37406965/51083189-d5dc3a80-173b-11e9-8ca0-28015e0893ac.png" alt="Mifos Mobile" />

# Mifos-Mobile Android Application for MifosX

An Android Application built on top of the MifosX Self-Service platform for end-user customers to view/transact on the accounts and loans they hold. Data visible to customers will be a sub-set of what staff can see. This is a native Android Application written in Kotlin.

![Kotlin](https://img.shields.io/badge/kotlin-%237F52FF.svg?style=flat-square&logo=kotlin&logoColor=white)
![Kotlin Multiplatform](https://img.shields.io/badge/Kotlin%20Multiplatform-4c8d3f?style=flat-square&logo=kotlin&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=flat-square&logo=android&logoColor=white)

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![GitHub license](https://img.shields.io/github/license/Naereen/StrapDown.js.svg)](https://github.com/openMF/mifos-mobile/blob/development/LICENSE)
[![GitHub release](https://img.shields.io/github/release/Naereen/StrapDown.js.svg)](https://github.com/openMF/mifos-mobile/releases/)
[![GitHub issues](https://img.shields.io/github/issues/Naereen/StrapDown.js.svg)](https://github.com/openMF/mifos-mobile/issues/)

[![Workflow for master/development branches](https://github.com/openMF/mifos-mobile/actions/workflows/master_dev_ci.yml/badge.svg)](https://github.com/openMF/mifos-mobile/actions/workflows/master_dev_ci.yml)
[![Slack](https://img.shields.io/badge/Slack-4A154B?style=flat-square&logo=slack&logoColor=white)](https://join.slack.com/t/mifos/shared_invite/zt-2wvi9t82t-DuSBdqdQVOY9fsqsLjkKPA)
[![Jira](https://img.shields.io/badge/jira-%230A0FFF.svg?style=flat-square&logo=jira&logoColor=white)](https://mifosforge.jira.com/jira/software/c/projects/MM/issues/?filter=allissues&jql=project%20%3D%20%22MM%22%20ORDER%20BY%20created%20DESC)
[![Zoom](https://img.shields.io/badge/Zoom-2D8CFF?style=flat-square&logo=zoom&logoColor=white)](https://us02web.zoom.us/meeting/register/xV5scn0XQpGXM5aUDFmUIA)

</div>

> \[!Note]
> **We're moving towards to Jira for issue tracking. Please use [Jira](https://mifosforge.jira.com/jira/software/c/projects/MM/issues/?filter=allissues&jql=project%20%3D%20%22MM%22%20ORDER%20BY%20created%20DESC) for issue tracking.**
> **And Join our [slack](https://join.slack.com/t/mifos/shared_invite/zt-2wvi9t82t-DuSBdqdQVOY9fsqsLjkKPA) community channel `mifos-mobile` to discuss all things about Mifos Mobile development, and keep discussions focused and avoid cross-posting across channels.**
> **Please join our daily Mobile Stand-Up on [Zoom](https://us02web.zoom.us/meeting/register/xV5scn0XQpGXM5aUDFmUIA).**

### Demo Credentials
Access the Mifos Mobile demo credentials on our [Jira Wiki page](https://mifosforge.jira.com/wiki/spaces/MP/pages/4537024513/Welcome+to+the+Mifos+Mobile+Apps+Community#%F0%9F%93%B2-Mifos-Mobile-App).

### How to Contribute
Thank you for your interest in contributing to the Mifos Mobile project by Mifos! We welcome all contributions and encourage you to follow these guidelines to ensure a smooth and efficient collaboration process.
To get started, please refer to the [Contribution Guide](https://github.com/openMF/mifos-mobile/wiki/Contribution-Guide) for detailed instructions on how to contribute to the project.

### Branch Policy
For development purposes, always pull from the **development** branch, as all contributions and updates are merged into this branch. Upon completion of development, changes are subsequently merged into the **master** branch, which represents the stable and bug-free version of the code.

### Development Setup
Please refer to the  [Development Setup Guide](https://github.com/openMF/mifos-mobile/wiki/Set-up-an-environment) for detailed instructions on configuring the development environment.

### Run the Web App

The web app requires JDK 21. Set `JAVA_HOME` to your JDK 21 installation, then start the Kotlin/JS development server from the repository root:

```bash
export JAVA_HOME=/usr/lib/jvm/jdk-21.0.9+10
export PATH="$JAVA_HOME/bin:$PATH"
./gradlew :cmp-web:jsBrowserRun
```

Open [http://localhost:8080](http://localhost:8080) after the Gradle task starts. Adjust `JAVA_HOME` if JDK 21 is installed in a different directory.

### Register a Test Self-Service User

Before testing registration, make sure the Core Banking/Fineract instance is prepared:

- Run the migration scripts that create the **Self Service User** role.
- Map the `READ_CLIENT` permission to the **Self Service User** role. Add any other permissions required by the endpoints as testing continues.
- Configure email and/or SMS delivery in Core Banking so the test user can receive the registration verification code. The app currently requests email authentication.
- Use the matching Fineract base URL and tenant ID. The app sends the tenant in the `Fineract-Platform-TenantId` request header.

To point the app at your Core Banking instance, update the source configuration before rebuilding:

- In [BaseURL.kt](core/network/src/commonMain/kotlin/org/mifos/mobile/core/network/utils/BaseURL.kt), set `API_ENDPOINT` to the Fineract host. Adjust `API_PATH` or `PROTOCOL_HTTPS` only if your deployment uses a different API path or scheme.
- In [KtorInterceptor.kt](core/network/src/commonMain/kotlin/org/mifos/mobile/core/network/utils/KtorInterceptor.kt), set `MIFOS_BANK_1` to the tenant ID sent in the `Fineract-Platform-TenantId` header.

The `FINERACT_BASE_URL` and `FINERACT_TENANT` variables in the `curl` example below are only for that command; the app does not read them as runtime configuration.

You can smoke-test the registration endpoint directly with `curl`. Replace the host, tenant, and sample user details with values for your environment:

```bash
FINERACT_BASE_URL="https://<fineract-host>/fineract-provider/api/v1/self"
FINERACT_TENANT="<tenant-id>"

curl --request POST "${FINERACT_BASE_URL}/registration" \
  --header "Content-Type: application/json" \
  --header "Fineract-Platform-TenantId: ${FINERACT_TENANT}" \
  --data '{
    "username": "test.user@example.com",
    "firstName": "Test",
    "lastName": "User",
    "email": "test.user@example.com",
    "mobileNumber": "+15555550100",
    "accountNumber": "<client-account-number>",
    "password": "<temporary-password>",
    "authenticationMode": "email"
  }'
```

### Web CI/CD Deployment

Pushing to `develop` builds the web distribution into a Docker image, publishes it to the existing Docker Hub repository as `spadecorebanking/spadeplatform:mifos-mobile.develop.<short-sha>`, and deploys it to Hostinger. The default web address is `https://mobile.spadecorebanking.com`; point that hostname's DNS to the Hostinger VPS and configure its Traefik HTTPS entry point and `letsencrypt` resolver.

Configure these GitHub Actions secrets in the repository:

- `DOCKER_USERNAME` and `DOCKERHUB_TOKEN` for publishing the image.
- `HOSTINGER_API_KEY` for deployment.
- `HOSTINGER_VM_ID` as a repository variable or secret.

The container uses JDK 21 to build the Kotlin/JS app and Nginx to serve the static distribution on port `8178` behind Traefik.

For deployment-specific logos and icons, see the [custom deployment image guide](docs/custom-deployment-branding.md).

### Committing Your Changes
After making changes in your local repository, you will need to commit them to your GitHub repository.
If you are unfamiliar with the process of committing changes, please refer to the [Committing Your Changes](https://github.com/openMF/mifos-mobile/wiki/Committing-Your-Changes) guide.

### Squashing Your Commits
To ensure a clean and organized Git history, contributors are encouraged to squash their commits before merging. Instructions on how to squash commits can be found in the [Squashing Your Commits](https://github.com/openMF/mifos-mobile/wiki/Squashing-Your-Commits) guide.

### Resolving Merge Conflicts
Occasionally, merge conflicts may arise when your pull request is being reviewed. These conflicts need to be resolved manually.
To learn how to resolve merge conflicts, please refer to the [Solving Merge Conflicts](https://github.com/openMF/mifos-mobile/wiki/Solving-Merge-Conflicts) guide.

### Instructions to Get the Latest APK

To download the latest APK navigate to the latest release [here](https://github.com/openMF/mifos-mobile/releases), and download the APK file from the assets section.

### Wiki
To know more about the project details and architecture guidelines, visit our [Wiki](https://github.com/openMF/mifos-mobile/wiki).

### Code of Conduct

Mifos has adopted a Code of Conduct that we expect project participants to adhere to. Please read [the full text](CODE_OF_CONDUCT.md) so that you can understand what actions will and will not be tolerated.

### Contributors

Special thanks to the incredible code contributors who continue to drive this project forward.

<a href="https://github.com/openMF/mifos-mobile/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=openMF/mifos-mobile"  alt="mifos-mobile-contributors"/>
</a>

