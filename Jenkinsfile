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

	triggers {
        pollSCM '@hourly'
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
		}

		stage("deploy") {
			when {
				branch 'master'
			}
			
			steps {
				sshagent(['0b266ecf-fa80-4fe8-bce8-4c723f5ba47a']) {
					sh "env REMOTE_USER=yapet-deploy REMOTE_HOST=eventhorizon.dmz.kruemel.home REMOTE_BASE=/var/www/jails/yapet/usr/local/www/apache24/data scripts/deploy.sh"
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
