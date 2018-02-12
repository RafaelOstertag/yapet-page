node("master") {
    stage("checkout") {
	checkout scm
    }

    stage("clean") {
	sh "make clean"
    }

    stage("build") {
	sh "make all"
    }
}
