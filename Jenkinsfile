pipeline {
  agent any

  environment{
    // CI = true
    DOCKER_TAG = getDockerTag()
  }

  stages {
    //stage pertama
    stage ('Build docker images'){
      steps{    
        script {
          app = docker.build("wordpress") 
        }    
      }
    }

    // //stage kedua
    // stage ('test docker images'){
    //   steps{    
    //     sh 'docker run -d --rm --name testimage -p 8081:80 yosafatdeny/reactapp-jcde'   
    //     //input message: "Finished test image? (Click procced to continue)"
    //   }      
    // } 

    // //stage ketiga
    // stage ('clean up docker test'){
    //   steps{    
    //     sh 'docker stop testimage'    
    //   }    
    // }   

    //stage keempat
    // stage ('push image to registry'){
    //   steps{    
    //     script{
    //       docker.withRegistry("https://registry.hub.docker.com", "dockerhub-yosafatdeny"){
    //         app.push("${DOCKER_TAG}")
    //         app.push("latest")    
    //       }    
    //     }    
    //   }    
    // }  

    //stage kelima
    // stage ('clean up docker images'){
    //   steps{    
    //     sh 'docker rmi yosafatdeny/reactapp-jcde:latest'    
    //   }    
    // } 

    //stage keenam
    stage ('deploy app to kubernetes clusterr'){
      steps{    
        sh "chmod +x changeTag.sh"
        sh "./changeTag.sh ${DOCKER_TAG}"
        withKubeConfig([credentialsId: 'kubeconfig-clusterjcde', serverUrl: 'https://34.101.152.59']){
          sh 'kubectl apply -f wordpress-config.k8s.yaml'    
        }      
      }    
    }
  }      
}

def getDockerTag(){
  def tag = sh script: "git rev-parse HEAD", returnStdout: true
  return tag    
}