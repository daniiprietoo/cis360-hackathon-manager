### Install MySQL:
Use Homebrew to install MySQL by running:
```bash
brew update
brew install mysql
```

### Start the MySQL Service:
To start the MySQL server and have it run as a background service, run:
```bash
brew services start mysql
```
You can verify the service is running with:
```bash
brew services list
```
### Secure the Installation:
MySQL provides a script to secure the installation, which lets you set a root password and remove insecure defaults:

```bash
mysql_secure_installation
```
You’ll be prompted to set a root password and answer a series of questions to remove test databases and anonymous users. Follow the prompts, answering “Y” (yes) for recommended changes.

### Connect to the MySQL Server:
Once MySQL is running and secured, connect using the command line:

```bash
mysql -u root -p
```
Enter the root password you set during the secure installation. You should now see the MySQL prompt.

### Create Your Database (Optional):
If you want to create a new database for your project, at the MySQL prompt run:

```sql
CREATE DATABASE HackathonManager;
USE HackathonManager;
```