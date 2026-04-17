FROM odoo:17.0
user root
RUN python3 -m pip install --upgrade pip
RUN apt-get update -y 
#RUN apt-get install -y python-dev 
RUN apt-get install -y python3-dev 
RUN apt-get install -y build-essential 
RUN apt-get install -y libssl-dev
RUN apt-get install -y libffi-dev 
RUN apt-get install -y libxml2-dev 
RUN apt-get install -y libxslt1-dev 
RUN apt-get install -y zlib1g-dev 
RUN apt-get install -y gcc
RUN apt-get install -y ffmpeg

RUN pip3 install wkhtmltopdf  
 
RUN pip3 install pycryptodome
RUN pip3 install simplejson 
RUN pip3 install xlrd 

RUN pip3 install cachetools 
RUN pip3 install cerberus  
RUN pip3 install pyquerystring 
RUN pip3 install jsondiff
RUN pip3 install parse-accept-language
RUN pip3 install html2text
RUN pip3 install translatepy==1.7
RUN pip3 install beautifulsoup4==4.9.3

RUN pip3 install oauthlib==1.0.3
RUN pip3 install sphinx==1.4.6
RUN pip3 install sphinx_tabs==1.1.6
RUN pip3 install sphinxcontrib-httpdomain==1.5.0
RUN pip3 install sphinx_rtd_theme==0.2.5b2
RUN pip3 install bravado_core
RUN pip3 install pandas
RUN pip3 install ffmpeg-python
RUN pip3 install python-ffmpeg-video-streaming
RUN pip3 install pyfcm 

user odoo
#sudo docker build -t adigielite/odoo17.1 .