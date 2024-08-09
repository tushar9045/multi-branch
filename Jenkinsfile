pipeline {
    agent any

    parameters {
        choice(
            name: 'JENKINSFILE_BRANCH',
            choices: ['main', 'test'],
            description: 'Select the branch for the Jenkinsfile'
        )
        choice(
            name: 'DOCKERFILE_BRANCH',
            choices: ['main', 'test'],
            description: 'Select the branch for the Dockerfile'
        )
    }

    environment {
        DOCKER_IMAGE = 'tusharsaini9045/my-image'
        DOCKER_TAG = 'v-1'
        DOCKERFILE_PATH = 'Dockerfile'
    }

    stages {
        stage('Checkout Jenkinsfile') {
            steps {
                checkout([$class: 'GitSCM',
                        branches: [[name: "*/${params.JENKINSFILE_BRANCH}"]],
                        userRemoteConfigs: scm.userRemoteConfigs
                    ])
            }
        }

        stage('Checkout Dockerfile') {
            steps {
                // Clone the repository with the Dockerfile in a separate directory
                script {
                    dir('dockerfile-repo') {
                        checkout([$class: 'GitSCM',
                                branches: [[name: "*/${params.DOCKERFILE_BRANCH}"]],
                                userRemoteConfigs: scm.userRemoteConfigs
                            ])
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile from the other branch
                    sh "docker build -t ${env.DOCKER_IMAGE}:${env.DOCKER_TAG} -f dockerfile-repo/${env.DOCKERFILE_PATH} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Login to Docker Hub (or your Docker registry)
                    withCredentials([usernamePassword(credentialsId: 'docker-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    }
                    // Push the Docker image
                    sh "docker push ${env.DOCKER_IMAGE}:${env.DOCKER_TAG}"
                }
            }
        }
    }
    post {
        always {
            script {
                cleanWs()

                sh "docker rmi ${env.DOCKER_IMAGE}:${env.DOCKER_TAG}"
            }
        }
    }
}

