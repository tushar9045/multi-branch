pipeline {
    agent any

    parameters {
        choice(
            name: 'DOCKERFILE_BRANCH',
            choices: ['main', 'test'],
            description: 'Select the branch for the Dockerfile'
        )
         string(
            name: 'TARGET_BRANCH',
            description: 'Branch to push the created file'
             
        )
         string(
            name: 'USER_NAME',
            description: 'Git user name'
        )
        string(
            name: 'USER_MAIL',
            description: 'Git user email'
        )
    }

    environment {
        DOCKER_IMAGE = 'tusharsaini9045/101airborne'
        DOCKER_TAG = 'v-1'
        DOCKERFILE_PATH = 'Dockerfile'
        
    }
    stages {
        // stage('Checkout Dockerfile') {
        //     steps {
        //         script {
        //             dir('dockerfile-repo') {
        //                 checkout([$class: 'GitSCM',
        //                         branches: [[name: "*/${params.DOCKERFILE_BRANCH}"]],
        //                         userRemoteConfigs: scm.userRemoteConfigs
        //                     ])
        //             }
        //         }
        //     }
        // }

        // stage('Build Docker Image') {
        //     steps {
        //         script {
        //             // Build the Docker image using the Dockerfile from the other branch
        //             sh "docker build -t ${env.DOCKER_IMAGE}:${env.DOCKER_TAG} -f dockerfile-repo/${env.DOCKERFILE_PATH} ."
        //         }
        //     }
        // }

        // stage('Push Docker Image') {
        //     steps {
        //         script {
                    
        //             withCredentials([usernamePassword(credentialsId: 'docker-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
        //                 sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
        //             }
        //             // Push the Docker image
        //             sh "docker push ${env.DOCKER_IMAGE}:${env.DOCKER_TAG}"
        //         }
        //     }
        // }
        stage('createfile') {
           steps {
              script{
                   dir('dockerfile-repo') {
                        sh "touch abcd.txt"
                    }
                      
              }
           }
        }
         stage('Commit and Push File') {
            steps {
                script {
                    dir('dockerfile-repo') {
                        sh "git checkout ${params.TARGET_BRANCH}"
                        sh "git add abcd.txt"
                        sh "git config user.name '${params.USER_NAME}'"
                        sh "git config user.email '${params.USER_MAIL}'"
                        sh "git commit -m 'Add abcd.txt file'"
                        sh "git push origin ${params.TARGET_BRANCH}"
                    }
                }
            }
        }
    
    }
}    

