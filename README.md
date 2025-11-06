# Nucleo-H563ZI STM32 Template Project

This is a ready-to-use STM32CubeIDE project for the Nucleo-H563ZI board. Clone it, rename, and start coding!

## Quick Start

1. Clone the repo (in Terminal/Powershell):

~~~
cd /path/to/your/workspace

git clone https://github.com/norta8t/nucleo-h563zi-template.git your-project-name

cd your-project-name
~~~

2. Open STM32CubeIDE.

3. Import the project: **File > Import > General > Existing Projects into Workspace** > Browse to the cloned folder > Select `nucleo-h563zi-template` > Finish.

4. Rename the project (to avoid conflicts):

- Right-click the project in Project Explorer > **Rename** > Enter your new name (e.g., `my-lab1`).

- STM32CubeIDE will update paths automatically. If prompted, regenerate code from the `.ioc` file (but this is optional).

5. Build: **Project > Build Project**.

6. Flash and run: Connect your Nucleo board > Right-click project > **Run As > STM32 Cortex-M C/C++ Application**.

## Tips
- To reconfigure pins/clocks: Double-click `nucleo-h563zi-template.ioc` > Make changes > Generate Code.
- If paths break after rename, clean/rebuild (Project > Clean).
- Requires STM32CubeH5 package (install via Help > Manage Embedded Software Packages).
