pipeline 
{
    agent any

    stages 
    {
        stage('Clone the project') 
        {
            steps 
            {
                sh '''
                    cd /M4
                    if [ -d /M4/bgapp ]; then 
                      cd /M4/bgapp
                      git pull https://github.com/georgilesov/bgapp.git 
                    else
                      git clone https://github.com/georgilesov/bgapp.git 
                    fi
                    '''
            }
        }
        stage('Build the images')
        {
            steps
            {
                sh '''
                cd /M4/bgapp
                docker image build -t img-db -f Dockerfile.db .
                docker image build -t img-web -f Dockerfile.web.apache .
                '''
            }
        }
        stage('Run the application')
        {
            steps
            {
                sh '''
                docker network ls | grep appnet || docker network create appnet
                docker container rm -f db || true
                docker container rm -f co-web || true
                docker container run -d --net appnet --name db -e MYSQL_ROOT_PASSWORD=12345 img-db
                docker container run -d --net appnet --name co-web -v /home/jenkins/M4/bgapp/web:/var/www/html -p 8000:80 img-web
                '''
            }
        }
    }
}
