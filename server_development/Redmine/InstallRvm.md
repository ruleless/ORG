# RVM ��װ������ָ��

## RVM �İ�װ�ű�

��ͨ�����½ű���װ rvm

    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	curl -sSL https://get.rvm.io | bash -s stable
	source ~/.bashrc
	source ~/.bash_profile

�޸� RVM �� Ruby ��װԴ�����ڵ��Ա��������������������߰�װ�ٶ�

    sed -i -E 's!https?://cache.ruby-lang.org/pub/ruby!https://ruby.taobao.org/mirrors/ruby!' $rvm_path/config/db

## Ruby �İ�װ���л�

�г���֪�� Ruby �汾

    rvm list known

��װһ�� Ruby �汾

    rvm install 2.2.0

�л� Ruby �汾

    rvm use 2.2.0

���������ΪĬ�ϰ汾������һ���Ժ��´򿪵Ŀ���̨Ĭ�ϵ� Ruby ��������汾

    rvm use 2.2.0 --default

��ѯ�Ѿ���װ��ruby

    rvm list

ж��һ���Ѱ�װ�汾

    rvm remove 1.8.7

## �����ַ�޸�

�� RubyGems �ľ����ַ�������Ա���

    $ gem sources --add https://ruby.taobao.org/ --remove https://rubygems.org/
	$ gem sources -l
	*** CURRENT SOURCES ***

	https://ruby.taobao.org # ��ȷ��ֻ�� ruby.taobao.org

���� Bundler �ľ���

    bundle config mirror.https://rubygems.org https://ruby.taobao.org

## gemset ��ʹ��

RVM ���������ṩһ���� Ruby �汾����Ļ����������Ը�����Ŀ����ͬ�� gemset.

gemset �������Ϊ��һ������������ Gem ������ÿһ�� gemset �����໥�����ġ�

��������������Ŀ��һ���� Rails 2.3 һ���� Rails3.0 gemset ���԰����ݵĽ������� Gem �������������ҷ�����л���

gemset �Ǹ����� Ruby ���԰汾����ģ����������� 1.9.2, ������һ���� rails3 �� gemset,���л��� 1.8.7 ��ʱ��rails3 ��� gemset �������ڡ�

### ���� gemset

    rvm use 1.8.7
	rvm gemset create rails23

Ȼ������趨�ѽ����� gemset ��Ϊ��ǰ����

### use ���������л����Ի��� gemset

ǰ���������Ѿ�����װ(���߽���)���������� list �����п�����

    rvm use 1.8.7
	rvm use 1.8.7@rails23

Ȼ�����а�װ�� Gem ���ǰ�װ����� gemset ֮�¡�

### �г���ǰ Ruby �� gemset

    rvm gemset list

### ��� gemset �е� Gem

����������һ�� gemset ������ Gem, �����°�װ���� Gem����������

    rvm gemset empty 1.8.7@rails23

### ɾ��һ�� gemset

    rvm gemset delete rails23

### ��Ŀ�Զ����� gemset

RVM �������Զ����� gemset��

����������һ�� Rails 3.1.3 ��Ŀ����Ҫ 1.9.3 �汾 Ruby���������̿���������

    rvm install 1.9.3
	rvm use 1.9.3
	rvm gemset create rails313
	rvm use 1.9.3@rails313

������뵽��ĿĿ¼������һ�� .rvmrc �ļ���

������ļ�����Ժܼ򵥵ļ�һ�����

    rvm use 1.9.3@rails313

Ȼ�������㵱ǰ Ruby ������ʲô��cd �������Ŀ��ʱ��RVM �������� Ruby 1.9.3 �� rails313 gemset.

## ʹ�� RVM ���ٲ��� Nginx + Passenger

���Ȱ�װ Passenger

    gem install passenger

Ȼ��ʹ�� passenger-install-nginx-module ����װ Nginx �Ͳ���

��Ϊ��һ����Ҫ root Ȩ�ޣ���ΪҪ���� Nginx�������� rvmsudo��

    rvmsudo passenger-install-nginx-module

Ȼ�������ѡ�������� Nginx Դ���Զ����밲װ�������Լ�ѡ�� Nginx Դ��λ�á�

ѡ�� Nginx �ֶ���װ�Ŀ�����ӱ�ı�������������Զ������ Nginx��

Ȼ��һ·���ذ�װ��Ĭ�ϵİ�װλ��Ϊ /opt/nginx.

Ȼ�󿴿� nginx.conf�����������ú��ˣ�ֻ��Ҫ���� root λ�ã�yourapp/public���Ϳ����ˡ�
