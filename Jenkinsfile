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
        stage('clone'){
            agent any
            steps{
                git 'https://github.com/tarangparikh/devops'
            }
        }
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
        stage('Deploy Docker Image to Docker Hub'){
            agent none
            steps{
                 script{
                        docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                   }
                 }
            }
        }
        stage('Deploy Docker Image to Node 1 via Rundeck'){
            agent any
                steps{
                    script{
                        step([$class: "RundeckNotifier",
                        includeRundeckLogs: true,
                        jobId: "149af780-50c1-4c87-be0f-282a285acc36",
                        rundeckInstance: "Rundeck",
                        shouldFailTheBuild: true,
                        shouldWaitForRunDeckJob: true,
                        tailLog:true])
                    }
                }
            
        }
    }
}
