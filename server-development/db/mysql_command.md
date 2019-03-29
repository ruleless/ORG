## ���ݲ���

### �����������ݿ�

    mysqldump -u username -p --default-character-set=utf8 dbname > filename(default code:latin1)

### ����һ����

    mysqldump -u username -p dbname table > filename(eg. t.sql)

### �������ݿ�

  1. ʹ�� source ����

        mysql>use dbname
		mysql>source filename(eg. db.sql)

  2. ʹ�� mysqldump ����

        mysqldump -u username -p dbname < filename.sql

  3. ʹ�� mysql ����

        mysql -u username -p -D dbname < filename.sql

## �����

1. �������ݿ�

        mysql> create database foo;

2. ��ʾ���е����ݿ�

        mysql> show databases;

3. ɾ�����ݿ�

        mysql> drop database foo;

4. �������ݿ�

        mysql> use foo;
		Database changed

5. �鿴��ǰʹ�õ����ݿ�

        mysql> select database();

6. ��ǰ���ݿ�����ı���Ϣ

        mysql> show tables;

## �����(����֮ǰӦ����ĳ�����ݿ�)

1. ����

        mysql> create table MyClass(
		     > id int(4) not null primary key auto_increment,
			 > name char(20) not null,
			 > sex int(4) not null default '0',
			 > degree double(16,2));

2. ��ȡ��ṹ

        mysql> describe MyClass(���� desc MyClass);
		mysql> show columns from MyClass;

3. ɾ����

        mysql> drop table MyClass;

4. ��������

        mysql> insert into MyClass values(1,'Tom',96.45),(2,'Joan',82.99), (2,'Wang', 96.59);

5. ��ѯ���е�����

        mysql> select * from MyClass;

6. ɾ����������

        mysql> delete from MyClass where id=1;

7. �޸ı�������

        mysql> update MyClass set name='Mary' where id=1;

8. �ڱ��������ֶ�

        mysql> alter table MyClass add passtest int(4) default '0';

9. ���ı���

        mysql> rename table MyClass to YouClass;

## �ֶ�����

1. INT[(M)] �ͣ� ������С��������

2. DOUBLE[(M,D)] [ZEROFILL] �ͣ� ������С(˫����)������������

3. DATE �������ͣ�֧�ֵķ�Χ��1000-01-01��9999-12-31��MySQL��YYYY-MM-DD��ʽ����ʾDATEֵ������������ʹ���ַ��������ְ�ֵ����DATE��

4. CHAR(M) �ͣ������ַ������ͣ����洢ʱ���������ÿո������ұߵ�ָ���ĳ���

5. BLOB TEXT���ͣ���󳤶�Ϊ65535(2^16-1)���ַ���

6. VARCHAR�ͣ��䳤�ַ�������

## mysql�û�����

1. �½��˻�

        mysql> insert into mysql.user
		     > (user,ssl_cipher,x509_issuer,x509_subject)
			 > values("testuser","","","");

2. Ȩ�޷���

        mysql> grant select, insert, delete, update
		���� > on test.*
		���� > to testuser@localhost;
		���� Query OK, 0 rows affected (0.00 sec)

   �˲���ʹtestuser�ܹ���ÿһ��test���ݿ��еı�ִ��SELECT��INSERT��DELETE�Լ�
   UPDATE��ѯ������

## MySql ʹ���ּ�

�� Windows �� MySql �Է�����ʽ���ڣ���ʹ��ǰӦȷ���˷����Ѿ�������δ��������
`net start mysql` ������������Linux������ʱ����`/etc/rc.d/init.d/mysqld start`
���ע��������Ӧ���й���ԱȨ�ޡ��հ�װ�õ� MySql ����һ����������� root �ʻ�
��һ�������ʻ������Ǻܴ�İ�ȫ����������һЩ��Ҫ��Ӧ������Ӧ����ȫ�Ծ�������ߣ�
������Ӧ�������ʻ�ɾ���� root�ʻ��������룬��������������У�

    use mysql;
	delete from User where User="";
	update User set Password=PASSWORD('newpassword') where User='root';

���Ҫ���û����õĵ�¼�ն˽������ƣ����Ը��� User ������Ӧ�û��� Host �ֶΣ��ڽ�
�������ϸ��ĺ�Ӧ�����������ݿ���񣬴�ʱ��¼ʱ���������������

    1. mysql -u root -p;
	2. mysql -u root -pnewpassword;
	3. mysql mydb -u root -p;
	4. mysql mydb -u root -p newpassword;

������������ǳ��ò�����һ���֣���ϸ����ɲο��ĵ����˴��� mydb ��Ҫ��¼�����ݿ�
�����ơ��ڽ��п�����ʵ��Ӧ���У��û���Ӧ��ֻ�� root �û������������ݿ⣬��Ȼʹ��
root�û����в���ʱ�ܷ��㣬�����ϵͳ�����ش�ȫ������Ҳ�����ڹ���������ߡ���
�Ǹ�һ��Ӧ����ʹ�õ��û�������ǡ�������ݿ�Ȩ�ޡ���һ��ֻ�������ݲ�����û���Ӧ��
����ɾ�����ݵ�Ȩ�ޡ�MySql ���û�������ͨ�� User ����ʵ�ֵģ�������û����õķ���
��������һ���� User �������Ӧ�������У�ͬʱ������Ӧ��Ȩ�ޣ�����ͨ�� GRANT ����
��������ĳ��Ȩ�޵��û�������GRANT�ĳ����÷����£�

    1. grant all on mydb.* to NewUserName@HostName identified by "password" ;
	2. grant usage on *.* to NewUserName@HostName identified by "password";
	3. grant select,insert,update on mydb.* to NewUserName@HostName identified by "password";
	4. grant update,delete on mydb.TestTable to NewUserName@HostName identified by "password";

��Ҫ�����û�����������Ӧ�����ϵ�Ȩ�޵Ĺ������������� grant �������
`with grant option` ѡ��������ò��� User ����ӵ��û���Password �ֶ�Ӧ��
password �������и��¼��ܣ��Է�����֮���Կ����롣������Щ�Ѿ����õ��û�Ӧ������
����Ȩ�޹�����û�Ӧ��ʱ����Ȩ�ޣ�����Ȩ�޿���ͨ������ User ����Ӧ�ֶΣ�Ҳ����ʹ
�� revoke ������

grant ��ָ����Ȩ�ް�����

  1. FILE: �� MySQL �������϶�д�ļ���
  2. PROCESS: ��ʾ��ɱ�����������û��ķ����̡߳�
  3. RELOAD: ���ط��ʿ��Ʊ�ˢ����־�ȡ�
  4. SHUTDOWN: �ر�MySQL����
  5. ���ݿ�/���ݱ�/������Ȩ�ޣ�
     1. Alter: �޸��Ѵ��ڵ����ݱ�(��������/ɾ����)��������
     2. Create: �����µ����ݿ�����ݱ�
     3. Delete: ɾ����ļ�¼��
     4. Drop: ɾ�����ݱ�����ݿ⡣
     5. INDEX: ������ɾ��������
     6. Insert: ���ӱ�ļ�¼��
     7. Select: ��ʾ/������ļ�¼��
     8. Update: �޸ı����Ѵ��ڵļ�¼��
  6. �ر��Ȩ�ޣ�
     1. ALL: �������κ���(��rootһ��)��
     2. USAGE: ֻ�����¼--����ʲôҲ����������

## ʾ��

һ������ͽ����Լ��������ݵ�ʾ��

    drop database if exists school; //�������SCHOOL��ɾ��
	create database school; //������SCHOOL
	use school; //�򿪿�SCHOOL
	create table teacher //������TEACHER
	(
	   id int(3) auto_increment not null primary key,
	   name char(10) not null,
	   address varchar(50) default '����',
	   year date
	); //�������

	//����Ϊ�����ֶ�
	insert into teacher values('','glchengang','����һ��','1976-10-10');
	insert into teacher values('','jack','����һ��','1975-12-23');

������� mysql ��ʾ���������������Ҳ���ԣ�����������ԡ�����Խ���������ԭ��д
��һ���ı��ļ��м���Ϊ school.sql��Ȼ���Ƶ� c:\ �£����� DOS ״̬����Ŀ¼
\mysql\bin��Ȼ������������

    mysql -u root -p ���� < c:\school.sql

## SELECT ���

### SELECT ���������﷨

select ���������﷨

    select[all|distinct|distinctrow|top]
	{*|talbe.*|[table.]field1[as alias1][,[table.]field2[as alias2][,��]]}
	from tableexpression[,��][in externaldatabase]
	[where��]
	[group by��]
	[having��]
	[order by��]
	[with owneraccess option]

˵����

  1. from �Ӿ�

     from �Ӿ�ָ���� select ������ֶε���Դ��from �Ӿ�����ǰ���һ�������ı��
	 ʽ(�ɶ��ŷֿ�)�����еı��ʽ��Ϊ��һ�����ơ��ѱ���Ĳ�ѯ���� inner join��
	 left join �� right join �õ��ĸ��Ͻ�����������ѯ�洢���ⲿ���ݿ⣬�� in
	 �Ӿ�֮��ָ��������·����

     ���� SQL ��䷵�������ж����Ŀͻ���

        select OrderID,Customer.customerID
		from Orders Customers
		where Orders.CustomerID=Customers.CustomeersID

  2. all��distinct��distinctrow��top ν��

	 * all �������� SQL ������������м�¼�����û��ָ�����ν�ʣ�Ĭ��Ϊ all��
	 * distinct ����ж����¼��ѡ���ֶε�������ͬ��ֻ����һ����
	 * distinctrow ������ظ��ļ�¼��ֻ����һ��
	 * top ��ʾ��ѯͷβ���ɼ�¼��Ҳ�ɷ��ؼ�¼�İٷֱȣ�����Ҫ�� TOP N PERCENT�Ӿ䣨����N ��ʾ�ٷֱȣ�

  3. �� as �Ӿ�Ϊ�ֶ�ȡ����

	 �����Ϊ���ص���ȡһ���µı��⣬���ߣ��������ֶεļ�����ܽ�֮�󣬲�����һ
	 ���µ�ֵ��ϣ�������ŵ�һ���µ�������ʾ������ as ������


  4. where �Ӿ�ָ����ѯ����

### WHERE �Ӿ��������ʽ

#### �Ƚ������

  * = ����
  * > ����
  * < С��
  * >= ���ڵ���
  * <= С�ڵ���
  * <> ������
  * !> ������
  * !< ��С��

#### ��Χ���ʽ(between �� not between)

    where OrderDate between #1/1/96# and #2/1/96#

#### �б�(in��not in)

    select CustomerID, CompanyName, ContactName, City
	from Customers
	where City in(��London��,�� Paris��,�� Berlin��)

#### ģʽƥ��(like)

like ���������һ�������ַ������ݵ��ֶ�ֵ�Ƿ�ƥ��һָ��ģʽ��like �������ʹ�õ�
ͨ������壺

  * �� �κ�һ����һ���ַ�
  * * ���ⳤ�ȵ��ַ�
  * # 0~9֮��ĵ�һ����
  * [�ַ��б�] ���ַ��б������һֵ
  * [���ַ��б�] �����ַ��б������һֵ
  * - ָ���ַ���Χ�����ߵ�ֵ�ֱ�Ϊ��������

�����������������ڣ�171��555-0000����171��555-9999֮��Ŀͻ�

    select CustomerID ,CompanyName,City,Phone
	from Customers
	where Phone like ��(171)555-####��

### �� ORDER BY �Ӿ�������

ORDER�Ӿ䰴һ�����������16�����ֶ������ѯ���������������ASC��Ҳ�����ǽ���
��DESC����ȱʡ������ORDER�Ӿ�ͨ������SQL��������� ORDER �Ӿ��ж����˶��
�ֶΣ������ֶε��Ⱥ�˳������

����

    SELECT ProductName,UnitPrice, UnitInStock
	FROM Products
	ORDER BY UnitInStock DESC , UnitPrice DESC, ProductName

ORDER BY �Ӿ��п������ֶ���ѡ���б��е�λ�úŴ����ֶ��������Ի���ֶ�����λ�úš�

�����������������������ͬ��Ч����

    SELECT ProductName,UnitPrice, UnitInStock
	FROM Products
	ORDER BY 1 DESC , 2 DESC,3

### �������ӹ�ϵʵ�ֶ���ѯ

�����ҳ�ͬһ�������й�Ӧ�̺Ϳͻ������֣�

    SELECT Customers.CompanyName, Suppliers.ComPany.Name
	FROM Customers, Suppliers
	WHERE Customers.City=Suppliers.City

### ������ܽ��ѯ���

�� SQL ���﷨�GROUP BY �� HAVING �Ӿ����������ݽ��л��ܡ�GROUP BY �Ӿ�ָ����
�����ļ����ֶ������飬������¼�������HAVING�Ӿ������Щ��¼��

�﷨��

    SELECT fidldlist
	FROM table
	WHERE criteria
	[GROUP BY groupfieldlist [HAVING groupcriteria]]

### �ۼ�����

1. SUM ���
2. AVG ƽ��ֵ
3. COUNT ���ʽ�м�¼����Ŀ
4. MAX ���ֵ
5. MIN ��Сֵ
6. VAR ����
7. STDEV ��׼���
8. FIRST ��һ��ֵ
9. LAST ���һ��ֵ

### ��Parameters��������������ѯ

�﷨:

    PARAMETERS name datatype[,name datatype[, ��]]

���� name �ǲ����ı�־��������ͨ����־�����ò�����Datatype ˵���������������͡�
ʹ��ʱҪ�� PARAMETERS ���������κ��������֮ǰ��

��:

    PARAMETERS[Low price] Currency,[Beginning date]datatime
	SELECT OrderID ,OrderAmount
	FROM Orders
	WHERE OrderAMount>[low price]
	AND OrderDate>=[Beginning date]

### ���ܲ�ѯ

��ν���ܲ�ѯ��ʵ������һ�ֲ�����ѯ�������Զ����ݿ���п��ٸ�Ч�Ĳ���������ѡ���
ѯΪĿ�ģ���ѡ���������������ݣ��ٶ����ݽ������������ܲ�ѯ�������²�ѯ��
ɾ����ѯ����Ӳ�ѯ�������ɱ��ѯ��

#### 1. ���²�ѯ

UPDATE �Ӿ����ͬʱ����һ���������е����ݡ���Ҳ����ͬʱ���Ķ���ֶε�ֵ��

    UPDATE ����
	SET ��ֵ
	WHERE ����

#### 2. ɾ����ѯ

DELETE �Ӿ����ʹ�û�ɾ�������Ĺ�ʱ�Ļ����ڵ����ݡ�

	DELETE *
	FROM ��Դ��
	WHERE ����

#### 3. ׷�Ӳ�ѯ

INSERT �Ӿ���Խ�һ����һ���¼׷�ӵ�һ���������β����INTO �Ӿ�ָ�������¼�¼
�ı�VALUES �ؼ���ָ���¼�¼������������ֵ��

    INSETR INTO Ŀ�ı���ѯ(�ֶ�1,�ֶ�2,��)
	VALUES(��ֵ1,��ֵ2,��)

#### 4. ���ɱ��ѯ

����һ���Եذ��������������ļ�¼������һ���±��С�ͨ��������¼�ı��ݻ򸱱�����Ϊ
����Ļ�����

    SELECT �ֶ�1,�ֶ�2,��
	INTO �±�[IN �ⲿ���ݿ�]
	FROM ��Դ���ݿ�
	WHERE ����

### ���ϲ�ѯ

UNION ������԰Ѷ����ѯ�Ľ���ϲ���һ�����������ʾ��

��:

    SELECT CompanyName,City
	FROM Suppliers
	WHERE Country = ��Brazil��
	UNION
	SELECT CompanyName,City
	FROM Customers
	WHERE Country = ��Brazil��

ע:

ȱʡ������£�UNION �Ӿ䲻�����ظ��ļ�¼���������ʾ���м�¼�����Լ� ALL ѡ��
UNION ����Ҫ���ѯ������ͬ��Ŀ���ֶΣ�����,�ֶ��������Ͳ�����ͬ��ÿһ����ѯ����
�п���ʹ�� GROUP BY �Ӿ� �� HAVING �Ӿ���з��顣Ҫ����ָ����˳������ʾ���ص���
�ݣ����������һ����ѯ��β��ʹ�� OREER BY �Ӿ䡣
