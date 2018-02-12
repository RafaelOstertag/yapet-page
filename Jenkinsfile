node("master") {
    stage("checkout") {
	checkout scm
    }

    stage("clean") {
	sh "gmake clean"
    }

    stage("build") {
	sh "gmake all"
    }

    stage("deploy") {
	sshagent(['0b266ecf-fa80-4fe8-bce8-4c723f5ba47a']) {
	    sh "scripts/deploy.sh"
	}
    }
}
