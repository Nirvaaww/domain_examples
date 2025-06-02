# 🖥️ PowerShell Domain Setup Scripts

This repository contains a set of **PowerShell scripts** designed to automate the setup of a **Domain Controller** on a Windows Server environment.

---

## ⚙️ What does this repository do?

These scripts allow you to:

- Install the **Active Directory Domain Services (AD DS)** role
- Promote a server to a **Domain Controller (DC)**
- Create a new **forest and domain**
- Configure basic settings like domain name, DSRM password, etc.

---

## 📁 Repository Contents

| File                      | Description                                               |
|---------------------------|-----------------------------------------------------------|
| `Install-ADDS.ps1`        | Installs the AD DS role on the server                    |
| `Promote-Domain.ps1`      | Promotes the server to Domain Controller                 |
| `Configure-Network.ps1`   | Sets static IP, DNS, and hostname (optional)             |
| `Check-Requirements.ps1`  | Verifies system readiness before setup                   |

> Each script is commented and easy to customize.

---

## ✅ Requirements

- Windows Server 2016 / 2019 / 2022
- PowerShell (Run as **Administrator**)
- Stable network connectivity
- Static IP and configured hostname (recommended)

---

## 🚀 How to Use

1. **Open PowerShell as Administrator**
2. **Clone the repository**:
   ```powershell
   git clone https://github.com/Nirvaaww/domain_examples.git
   cd domain_examples
