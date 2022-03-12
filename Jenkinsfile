pipeline {
    agent {
		label "freebsd&&amd64"
    }

    options {
        ansiColor('xterm')
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10')
        timeout(time: 1, unit: 'HOURS')
        timestamps()
    }

    stages {
		stage("clean") {
			steps {
				sh "gmake clean"
			}
		}

		stage("build") {
			steps {
				sh "gmake all"
			}

            post {
                always {
                    // Some files are created without write access
                    sh "chmod -R u+w *"
                }
            }
		}

		stage("deploy") {
			when {
				branch 'master'
			}
			
			steps {
				sshagent(['897482ed-9233-4d56-88c3-254b909b6316']) {
					sh "env REMOTE_USER=ec2-deploy REMOTE_HOST=ec2-52-29-59-221.eu-central-1.compute.amazonaws.com REMOTE_BASE=/data/www/yapet.guengel.ch scripts/deploy.sh"
				}
			}
		}
    }

    post {
		always {
			emailext body: '''$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS:

Check console output at $BUILD_URL to view the results.''', recipientProviders: [[$class: 'DevelopersRecipientProvider']], subject: '[jenkins.guengel.ch] $PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!', to: 'rafi@guengel.ch'
		}
    }
}
