pipeline {
    agent any

    tools {
        jdk 'JAVA_HOME'
        maven 'MAVEN_HOME'
    }

    options {
        timestamps()
    }

    stages {

        stage('Checkout') {
            steps {
                echo "========== Checkout =========="
                checkout scm
            }
        }

        stage('Environment Check') {
            steps {
                sh '''
                    echo "========== Environment =========="
                    echo "User       : $(whoami)"
                    echo "Workspace  : $WORKSPACE"
                    echo "JAVA_HOME  : $JAVA_HOME"
                    echo "PATH       : $PATH"

                    echo
                    echo "Java Version"
                    java -version

                    echo
                    echo "Maven Version"
                    mvn -version

                    echo
                    echo "Git Version"
                    git --version
                '''
            }
        }

        stage('Compile') {
            steps {
                echo "========== Compile =========="
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                echo "========== Unit Tests =========="
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                echo "========== Package =========="
                sh 'mvn package -DskipTests'
            }
        }

        stage('Archive Artifact') {
            steps {
                echo "========== Archive =========="
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
    }

    post {

        success {
            echo "========================================="
            echo "CI Pipeline Completed Successfully"
            echo "Artifact Generated Successfully"
            echo "========================================="
        }

        failure {
            echo "========================================="
            echo "CI Pipeline Failed"
            echo "========================================="
        }

        always {
            cleanWs()
        }
    }
}