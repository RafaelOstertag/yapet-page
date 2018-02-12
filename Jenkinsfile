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
}
