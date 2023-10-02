<div align="center">
  <a href="https://edgeless-project.eu/" target="blank">
    <img src="static/assets/images/github-mark-white.png" width="100" alt="Worldline - Edgeless logo" />
    <img src="static/assets/images/github-actions-logo.png" width="75" alt="Worldline - Edgeless logo" />
  </a>
  <h2>Github Actions example for NestJS project</h2>
</div>

<br>

## Introduction
Github Actions is a CI/CD solution for repositories located in github platform. The CI/CD task will be executed triggered by repository events. 
We have two main concepts on Github Actions:

### Workflows
A workflow is a set of task that will be perform when a repository event is triggered. The type of event that must be execute a workflow is configured in a workflow property.
A workflow is defined by a YAML file and must be included under the path `.github/workflows` in the root of the repository files.

A workflow execute an aggrupation of task called *jobs* in parallel, and each job is executed in an individual virtual machines called *runners* (hosted by github or an external self-hosted runners).

A workflow can be reused by other workflows in a job, but the job cannot have any other steps that the reusable workflow and have some usage limitations that you can find in the documentation

### Actions
An action is an individual task that you can combine to create jobs and custom a workflow. Unlike reusing workflows an action can be used as an additional job steb, for this reason you can use more than one action in the same workflow job. The syntax of the actions is similar than the workflow syntax and are defined by a YAML file with some differences.

The actions could be published with his own repository to be shared with the community or you can create your own actions for your own repository. Also you can share actions from a private repository with some configuration.

> **Note**: You can find some useful links for moe information about github actions in the [Related links](#related-links) document section

<br>

## Workflow and Custom action examples:

  - ### Workflow examples:

    - #### **CI Workflow triggered by push or pull_request events on main branch**
      - Workflow path: `.github/workflows/ci.yml`
      
        This workflows will trigger on push and pull_request events on the main branch. The workflow will run two jobs with similar structure:
        1. Set the a github hosted runner an ubuntu image
        2. Run two actions published in the github market by Github:
            1. **action/checkout**: Download the repository in the virtual machine
            2. **action/setup-node**: Install Node.js and configure the environment for the project
        3. Execute commands in the OS default shell 
      
    <br>

    - #### **CI Manual workflow executing the same job in a combination of OS and Node version using github custom action**
      - Workflow path: `.github/workflows/manual_ci.yml`
        
        This workflow only be trigger manually using the GitHub Actions UI or the GitHub API using an specific event. The workflow contains only one job and is configured to run in all possible combinations of runners and Node versions configured in the strategy matrix property of the job.
        The the workflow only have two steps that runs a github action:
        1. **actions/checkout** Download the repository
        2. **./.github/actions/node-basic-ci-unix-action**: custom action located in the repository to configure Node.js in the virtual machine, build the app and run the tests
      
    <br>

    - #### **CI/CD Workflow triggered on release event that reuse a workflow and publish in docker hub**
      - Workflow path: `.github/workflows/docker-image.yml`
        A workflow can be reused by other workflows but unlike actions, if a job on a workflow reused a workflow there cannot be more steps in this job. In this workflow

  - ### Custom Action examples:

    - #### **Action located in a project repository**:
      - Action path: `.github/workflows/node-basic-ci-unix-action.yml`

        Custom action that configure node, install the project dependencies, build the project and run the tests. The image accept two inputs values, the node version (20.x by default) and the package manager for caching in the default directory (npm like default value)

    - #### **Action with his own repository published in github marketplace**:
      Is an example of the same action that are located in this repository but published like public action on github marketplace:
        - Github repository: https://github.com/arensis/node-ci-action
        - Github marketplace link: https://github.com/marketplace/actions/node-ci-action

      To be published in a Github Marketplace must be fullfil two conditions:
        1. The action has its own repository
        2. The repository must be public
    
        If the two conditions are fullfilled in the settings of the repository you can publish the action in the marketplace accepting the Github terms and conditions and creating a release for the repository.

### Related links:
- [Github actions marketplace](https://github.com/marketplace?category=&query=&type=actions&verification=)
- [Github Actions documentation](https://docs.github.com/actions)
  - [Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
    - [**on** property syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#on)
    - [**job** property syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobs)
    - [**strategy.matrix** property syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstrategymatrix)
    - [**step** property syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idsteps)
      - [**uses** property syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepsuses)
      - [**shell** property syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepsshell)
    - [Events that trigger workflows](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows)
    - [Contexts](https://docs.github.com/en/actions/learn-github-actions/contexts#about-contexts)
      - [Github context](https://docs.github.com/en/actions/learn-github-actions/contexts#github-context)
      - [Context-availability](https://docs.github.com/en/actions/learn-github-actions/contexts#context-availability)
    - [Expressions in workflows and github actions](https://docs.github.com/en/actions/learn-github-actions/expressions)
    - [Reusing workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows)
      - [Access to reusable workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows#access-to-reusable-workflows)
      - [Limitations](https://docs.github.com/en/actions/using-workflows/reusing-workflows#limitations)
        - [Nesting reusable workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows#nesting-reusable-workflows)
    - [Github hosted runners](https://docs.github.com/en/actions/using-github-hosted-runners)
    - [Self-hosted runners](https://docs.github.com/en/actions/hosting-your-own-runners)
  - [Custom Actions](https://docs.github.com/en/actions/creating-actions/about-custom-actions)
    - [Github actions syntax](https://docs.github.com/en/actions/creating-actions/metadata-syntax-for-github-actions)
    - [**Docker container actions**](https://docs.github.com/en/actions/creating-actions/about-custom-actions#docker-container-actions)
      - [Creating Docker container Action](https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action)
    - [**Javascript Action**](https://docs.github.com/en/actions/creating-actions/about-custom-actions#javascript-actions)
      - [Creating a Javascript action](https://docs.github.com/en/actions/creating-actions/creating-a-javascript-action)
    - [**Composite Actions**](https://docs.github.com/en/actions/creating-actions/about-custom-actions#composite-actions)
      - [Creating a composite action](https://docs.github.com/en/actions/creating-actions/about-custom-actions#composite-actions)
  - [Deploy to cloud provider](https://docs.github.com/en/actions/deployment/deploying-to-your-cloud-provider)
    - [Deploy to Amazon ECS](https://docs.github.com/en/actions/deployment/deploying-to-your-cloud-provider/deploying-to-amazon-elastic-container-service)
  - [Sharing actions and workflows from your private repository](https://docs.github.com/en/actions/creating-actions/sharing-actions-and-workflows-from-your-private-repository)

