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
                echo "Checking out source code..."
                checkout scm
            }
        }

        stage('Environment Check') {
            steps {
                sh '''
                    echo "=============================="
                    echo "User        : $(whoami)"
                    echo "Workspace   : $WORKSPACE"
                    echo "JAVA_HOME   : $JAVA_HOME"
                    echo "PATH        : $PATH"

                    echo
                    echo "Java Version"
                    java -version

                    echo
                    echo "Maven Version"
                    mvn -version

                    echo
                    echo "Git Version"
                    git --version
                    echo "=============================="
                '''
            }
        }

        stage('Compile') {
            steps {
                echo "Compiling project..."
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                echo "Running Unit Tests..."
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                echo "Packaging application..."
                sh 'mvn package -DskipTests'
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    chmod +x deploy.sh
                    ./deploy.sh
                '''
            }
        }

    }

    post {

        success {
            echo "===================================="
            echo "BUILD SUCCESSFUL"
            echo "Application deployed successfully."
            echo "===================================="
        }

        failure {
            echo "===================================="
            echo "BUILD FAILED"
            echo "Check Console Output."
            echo "===================================="
        }

        always {
            cleanWs()
        }
    }
}
