## How to contribute to Autocaliweb

First of all, we would like to thank you for reading this text. We are happy you are willing to contribute to Autocaliweb.

### **General**

**Communication language** is English. Google translated texts are not as bad as you might think, they are usually understandable, so don't worry if you generate your post that way.

**Autocaliweb** is not **Calibre** or **Calibre-Web**. If you are having a question regarding Calibre please post this at their repositories.

If you are having **Basic Installation Problems**, please consider using your favorite search engine to find a solution. In case you can't find a solution, we are happy to help you.

We can offer only very limited support regarding configuration of **Reverse-Proxy Installations**, **OPDS-Reader** or other programs in combination with Autocaliweb.

### **Translation**

Some of the user languages in Autocaliweb having missing translations. We are happy to add the missing texts if you translate them. Create a Pull Request or create an issue with the .po file attached. To display all book languages in your native language an additional file is used (iso_language_names.py). The content of this file is auto-generated with the corresponding translations of Calibre, please do not edit this file on your own.

### **Documentation**

The documentation is not finished at this time but can be found [here](https://github.com/gelbphoenix/autocaliweb/wiki).

### **Reporting a bug**

For **security vulnerability** in Autocaliweb look at the [SECURITY file](https://github.com/gelbphoenix/autocaliweb/blob/master/SECURITY.md) for how to repose those.

Ensure the **bug was not already reported** by searching on GitHub under [Issues](https://github.com/gelbphoenix/autocaliweb/issues).

If you're unable to find an **open issue** addressing the problem, open a [new one](https://github.com/gelbphoenix/autocaliweb/issues/new/choose). Be sure to include a **title** and **clear description**, as much relevant information as possible, the **issue form** helps you provide the right information. **_Deleting the form and just pasting the stack trace doesn't speed up fixing the problem._** If your issue could be resolved, please close the issue.

### **Feature Request**

If there is a feature missing in Calibre-Web and you can't find a feature request in the [Issues](https://github.com/gelbphoenix/autocaliweb/issues) section, you could create a [feature request](https://github.com/gelbphoenix/autocaliweb/issues/new?template=feature_request.md).

### **Contributing code to Autocaliweb**

Open a new GitHub pull request with the patch. Ensure the PR description clearly describes the problem and solution. Include the relevant issue number if applicable. Also is it preferred that you sign your commit.

Please check if your code runs with python 3. If possible and the feature is related to operating system functions, try to check it on Windows and Linux.
You should check your code with ESLint before contributing, a configuration file can be found in the projects root folder.
