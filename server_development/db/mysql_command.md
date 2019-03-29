## 备份操作

### 导出整个数据库

    mysqldump -u username -p --default-character-set=utf8 dbname > filename(default code:latin1)

### 导出一个表

    mysqldump -u username -p dbname table > filename(eg. t.sql)

### 导入数据库

  1. 使用 source 命令

        mysql>use dbname
		mysql>source filename(eg. db.sql)

  2. 使用 mysqldump 命令

        mysqldump -u username -p dbname < filename.sql

  3. 使用 mysql 命令

        mysql -u username -p -D dbname < filename.sql

## 库操作

1. 创建数据库

        mysql> create database foo;

2. 显示所有的数据库

        mysql> show databases;

3. 删除数据库

        mysql> drop database foo;

4. 连接数据库

        mysql> use foo;
		Database changed

5. 查看当前使用的数据库

        mysql> select database();

6. 当前数据库包含的表信息

        mysql> show tables;

## 表操作(操作之前应连接某个数据库)

1. 建表

        mysql> create table MyClass(
		     > id int(4) not null primary key auto_increment,
			 > name char(20) not null,
			 > sex int(4) not null default '0',
			 > degree double(16,2));

2. 获取表结构

        mysql> describe MyClass(或者 desc MyClass);
		mysql> show columns from MyClass;

3. 删除表

        mysql> drop table MyClass;

4. 插入数据

        mysql> insert into MyClass values(1,'Tom',96.45),(2,'Joan',82.99), (2,'Wang', 96.59);

5. 查询表中的数据

        mysql> select * from MyClass;

6. 删除表中数据

        mysql> delete from MyClass where id=1;

7. 修改表中数据

        mysql> update MyClass set name='Mary' where id=1;

8. 在表中增加字段

        mysql> alter table MyClass add passtest int(4) default '0';

9. 更改表名

        mysql> rename table MyClass to YouClass;

## 字段类型

1. INT[(M)] 型： 正常大小整数类型

2. DOUBLE[(M,D)] [ZEROFILL] 型： 正常大小(双精密)浮点数字类型

3. DATE 日期类型：支持的范围是1000-01-01到9999-12-31。MySQL以YYYY-MM-DD格式来显示DATE值，但是允许你使用字符串或数字把值赋给DATE列

4. CHAR(M) 型：定长字符串类型，当存储时，总是是用空格填满右边到指定的长度

5. BLOB TEXT类型，最大长度为65535(2^16-1)个字符。

6. VARCHAR型：变长字符串类型

## mysql用户管理

1. 新建账户

        mysql> insert into mysql.user
		     > (user,ssl_cipher,x509_issuer,x509_subject)
			 > values("testuser","","","");

2. 权限分配

        mysql> grant select, insert, delete, update
		　　 > on test.*
		　　 > to testuser@localhost;
		　　 Query OK, 0 rows affected (0.00 sec)

   此操作使testuser能够在每一个test数据库中的表执行SELECT，INSERT和DELETE以及
   UPDATE查询操作。

## MySql 使用手记

在 Windows 中 MySql 以服务形式存在，在使用前应确保此服务已经启动，未启动可用
`net start mysql` 命令启动。而Linux中启动时可用`/etc/rc.d/init.d/mysqld start`
命令，注意启动者应具有管理员权限。刚安装好的 MySql 包含一个含空密码的 root 帐户
和一个匿名帐户，这是很大的安全隐患，对于一些重要的应用我们应将安全性尽可能提高，
在这里应把匿名帐户删除、 root帐户设置密码，可用如下命令进行：

    use mysql;
	delete from User where User="";
	update User set Password=PASSWORD('newpassword') where User='root';

如果要对用户所用的登录终端进行限制，可以更新 User 表中相应用户的 Host 字段，在进
行了以上更改后应重新启动数据库服务，此时登录时可用如下类似命令：

    1. mysql -u root -p;
	2. mysql -u root -pnewpassword;
	3. mysql mydb -u root -p;
	4. mysql mydb -u root -p newpassword;

上面命令参数是常用参数的一部分，详细情况可参考文档。此处的 mydb 是要登录的数据库
的名称。在进行开发和实际应用中，用户不应该只用 root 用户进行连接数据库，虽然使用
root用户进行测试时很方便，但会给系统带来重大安全隐患，也不利于管理技术的提高。我
们给一个应用中使用的用户赋予最恰当的数据库权限。如一个只进行数据插入的用户不应赋
予其删除数据的权限。MySql 的用户管理是通过 User 表来实现的，添加新用户常用的方法
有两个，一是在 User 表插入相应的数据行，同时设置相应的权限；二是通过 GRANT 命令
创建具有某种权限的用户。其中GRANT的常用用法如下：

    1. grant all on mydb.* to NewUserName@HostName identified by "password" ;
	2. grant usage on *.* to NewUserName@HostName identified by "password";
	3. grant select,insert,update on mydb.* to NewUserName@HostName identified by "password";
	4. grant update,delete on mydb.TestTable to NewUserName@HostName identified by "password";

若要给此用户赋予他在相应对象上的权限的管理能力，可在 grant 后面添加
`with grant option` 选项。而对于用插入 User 表添加的用户，Password 字段应用
password 函数进行更新加密，以防不轨之人窃看密码。对于那些已经不用的用户应给予清
除，权限过界的用户应及时回收权限，回收权限可以通过更新 User 表相应字段，也可以使
用 revoke 操作。

grant 可指定的权限包括：

  1. FILE: 在 MySQL 服务器上读写文件。
  2. PROCESS: 显示或杀死属于其它用户的服务线程。
  3. RELOAD: 重载访问控制表，刷新日志等。
  4. SHUTDOWN: 关闭MySQL服务。
  5. 数据库/数据表/数据列权限：
     1. Alter: 修改已存在的数据表(例如增加/删除列)和索引。
     2. Create: 建立新的数据库或数据表。
     3. Delete: 删除表的记录。
     4. Drop: 删除数据表或数据库。
     5. INDEX: 建立或删除索引。
     6. Insert: 增加表的记录。
     7. Select: 显示/搜索表的记录。
     8. Update: 修改表中已存在的记录。
  6. 特别的权限：
     1. ALL: 允许做任何事(和root一样)。
     2. USAGE: 只允许登录--其它什么也不允许做。

## 示例

一个建库和建表以及插入数据的示例

    drop database if exists school; //如果存在SCHOOL则删除
	create database school; //建立库SCHOOL
	use school; //打开库SCHOOL
	create table teacher //建立表TEACHER
	(
	   id int(3) auto_increment not null primary key,
	   name char(10) not null,
	   address varchar(50) default '深圳',
	   year date
	); //建表结束

	//以下为插入字段
	insert into teacher values('','glchengang','深圳一中','1976-10-10');
	insert into teacher values('','jack','深圳一中','1975-12-23');

如果你在 mysql 提示符键入上面的命令也可以，但不方便调试。你可以将以上命令原样写
入一个文本文件中假设为 school.sql，然后复制到 c:\ 下，并在 DOS 状态进入目录
\mysql\bin，然后键入以下命令：

    mysql -u root -p 密码 < c:\school.sql

## SELECT 语句

### SELECT 语句的完整语法

select 语句的完整语法

    select[all|distinct|distinctrow|top]
	{*|talbe.*|[table.]field1[as alias1][,[table.]field2[as alias2][,…]]}
	from tableexpression[,…][in externaldatabase]
	[where…]
	[group by…]
	[having…]
	[order by…]
	[with owneraccess option]

说明：

  1. from 子句

     from 子句指定了 select 语句中字段的来源。from 子句后面是包含一个或多个的表达
	 式(由逗号分开)，其中的表达式可为单一表名称、已保存的查询或由 inner join、
	 left join 或 right join 得到的复合结果。如果表或查询存储在外部数据库，在 in
	 子句之后指明其完整路径。

     下列 SQL 语句返回所有有定单的客户：

        select OrderID,Customer.customerID
		from Orders Customers
		where Orders.CustomerID=Customers.CustomeersID

  2. all、distinct、distinctrow、top 谓词

	 * all 返回满足 SQL 语句条件的所有记录。如果没有指明这个谓词，默认为 all。
	 * distinct 如果有多个记录的选择字段的数据相同，只返回一个。
	 * distinctrow 如果有重复的记录，只返回一个
	 * top 显示查询头尾若干记录。也可返回记录的百分比，这是要用 TOP N PERCENT子句（其中N 表示百分比）

  3. 用 as 子句为字段取别名

	 如果想为返回的列取一个新的标题，或者，经过对字段的计算或总结之后，产生了一
	 个新的值，希望把它放到一个新的列里显示，则用 as 保留。


  4. where 子句指定查询条件

### WHERE 子句条件表达式

#### 比较运算符

  * = 等于
  * > 大于
  * < 小于
  * >= 大于等于
  * <= 小于等于
  * <> 不等于
  * !> 不大于
  * !< 不小于

#### 范围表达式(between 和 not between)

    where OrderDate between #1/1/96# and #2/1/96#

#### 列表(in，not in)

    select CustomerID, CompanyName, ContactName, City
	from Customers
	where City in(‘London’,’ Paris’,’ Berlin’)

#### 模式匹配(like)

like 运算符检验一个包含字符串数据的字段值是否匹配一指定模式。like 运算符里使用的
通配符含义：

  * ？ 任何一个单一的字符
  * * 任意长度的字符
  * # 0~9之间的单一数字
  * [字符列表] 在字符列表里的任一值
  * [！字符列表] 不在字符列表里的任一值
  * - 指定字符范围，两边的值分别为其上下限

例：返回邮政编码在（171）555-0000到（171）555-9999之间的客户

    select CustomerID ,CompanyName,City,Phone
	from Customers
	where Phone like ‘(171)555-####’

### 用 ORDER BY 子句排序结果

ORDER子句按一个或多个（最多16个）字段排序查询结果，可以是升序（ASC）也可以是降序
（DESC），缺省是升序。ORDER子句通常放在SQL语句的最后。若 ORDER 子句中定义了多个
字段，则按照字段的先后顺序排序。

例：

    SELECT ProductName,UnitPrice, UnitInStock
	FROM Products
	ORDER BY UnitInStock DESC , UnitPrice DESC, ProductName

ORDER BY 子句中可以用字段在选择列表中的位置号代替字段名，可以混合字段名和位置号。

例，下面的语句产生与上列相同的效果：

    SELECT ProductName,UnitPrice, UnitInStock
	FROM Products
	ORDER BY 1 DESC , 2 DESC,3

### 运用连接关系实现多表查询

例，找出同一个城市中供应商和客户的名字：

    SELECT Customers.CompanyName, Suppliers.ComPany.Name
	FROM Customers, Suppliers
	WHERE Customers.City=Suppliers.City

### 分组和总结查询结果

在 SQL 的语法里，GROUP BY 和 HAVING 子句用来对数据进行汇总。GROUP BY 子句指明了
按照哪几个字段来分组，而将记录分组后，用HAVING子句过滤这些记录。

语法：

    SELECT fidldlist
	FROM table
	WHERE criteria
	[GROUP BY groupfieldlist [HAVING groupcriteria]]

### 聚集函数

1. SUM 求和
2. AVG 平均值
3. COUNT 表达式中记录的数目
4. MAX 最大值
5. MIN 最小值
6. VAR 方差
7. STDEV 标准误差
8. FIRST 第一个值
9. LAST 最后一个值

### 用Parameters声明创建参数查询

语法:

    PARAMETERS name datatype[,name datatype[, …]]

其中 name 是参数的标志符，可以通过标志符引用参数。Datatype 说明参数的数据类型。
使用时要把 PARAMETERS 声明置于任何其他语句之前。

例:

    PARAMETERS[Low price] Currency,[Beginning date]datatime
	SELECT OrderID ,OrderAmount
	FROM Orders
	WHERE OrderAMount>[low price]
	AND OrderDate>=[Beginning date]

### 功能查询

所谓功能查询，实际上是一种操作查询，它可以对数据库进行快速高效的操作。它以选择查
询为目的，挑选出符合条件的数据，再对数据进行批处理。功能查询包括更新查询，
删除查询，添加查询，和生成表查询。

#### 1. 更新查询

UPDATE 子句可以同时更改一个或多个表中的数据。它也可以同时更改多个字段的值。

    UPDATE 表名
	SET 新值
	WHERE 条件

#### 2. 删除查询

DELETE 子句可以使用户删除大量的过时的或冗于的数据。

	DELETE *
	FROM 来源表
	WHERE 条件

#### 3. 追加查询

INSERT 子句可以将一个或一组记录追加到一个或多个表的尾部。INTO 子句指定接受新记录
的表。VALUES 关键字指定新记录所包含的数据值。

    INSETR INTO 目的表或查询(字段1,字段2,…)
	VALUES(数值1,数值2,…)

#### 4. 生成表查询

可以一次性地把所有满足条件的记录拷贝到一张新表中。通常制作记录的备份或副本或作为
报表的基础。

    SELECT 字段1,字段2,…
	INTO 新表[IN 外部数据库]
	FROM 来源数据库
	WHERE 条件

### 联合查询

UNION 运算可以把多个查询的结果合并到一个结果集里显示。

例:

    SELECT CompanyName,City
	FROM Suppliers
	WHERE Country = ‘Brazil’
	UNION
	SELECT CompanyName,City
	FROM Customers
	WHERE Country = ‘Brazil’

注:

缺省的情况下，UNION 子句不返回重复的记录。如果想显示所有记录，可以加 ALL 选项
UNION 运算要求查询具有相同数目的字段，但是,字段数据类型不必相同。每一个查询参数
中可以使用 GROUP BY 子句 或 HAVING 子句进行分组。要想以指定的顺序来显示返回的数
据，可以在最后一个查询的尾部使用 OREER BY 子句。
