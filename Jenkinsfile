pipeline {
    agent any

    parameters {
        choice(
            name: 'DOCKERFILE_BRANCH',
            choices: ['main', 'test'],
            description: 'Select the branch for the Dockerfile'
        )
    }

    environment {
        DOCKER_IMAGE = 'tusharsaini9045/101Airborne'
        DOCKER_TAG = 'v-1'
        DOCKERFILE_PATH = 'Dockerfile'
    }

        stage('Checkout Dockerfile') {
            steps {
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
                    
                    withCredentials([usernamePassword(credentialsId: 'docker-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    }
                    // Push the Docker image
                    sh "docker push ${env.DOCKER_IMAGE}:${env.DOCKER_TAG}"
                }
            }
        }
        stage('createfile') {
           steps {
              script{
                      sh "touch ${WORKSPACE}/abcd.txt"
              }
           }
        }
    
    }

