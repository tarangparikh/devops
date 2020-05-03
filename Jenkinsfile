pipeline {
    environment {
        registry = "tarangparikh/calculator"
        registryCredential = 'dockerhub'
        dockerImage = ''
    }
    agent none
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Build') {
            agent {
                    docker {
                        image 'maven:3-alpine'
                        args '-v /root/.m2:/root/.m2'

                    }
            }
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Test') {
            agent {
                    docker {
                        image 'maven:3-alpine'
                        args '-v /root/.m2:/root/.m2'
                    }
            }
            steps {
                sh 'mvn test'
            }
        }
        stage('Build Docker Image'){
            agent none
            steps{
               script{
                   dockerImage = docker.build(registry)
               }
            }
        }
        stage('Deploy Docker Image'){
            agent none
            steps{
                 script{
                   withCredentials([usernamePassword(credentialsId: registryCredential, passwordVariable: 'pass', usernameVariable: 'user')]) {
                      echo user
                   }
                 }
            }
        }
    }
}