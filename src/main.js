const { app, BrowserWindow, nativeImage, Tray } = require('electron');
const path = require('path');

let mainWindow;
let tray;

function createWindow() {
  mainWindow = new BrowserWindow({
    width: 1000,
    height: 800,
    icon: path.join(__dirname, 'icon.png'),
                                 webPreferences: {
                                   nodeIntegration: false,
                                 contextIsolation: true,
                                 },
  });

  // Set user-agent to a recent Chrome user-agent string (example: Chrome 114 on Linux)
  const chromeUserAgent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36";
  mainWindow.webContents.setUserAgent(chromeUserAgent);

  mainWindow.loadURL('https://web.whatsapp.com');
  mainWindow.setMenu(null);

  mainWindow.on('closed', () => {
    mainWindow = null;
  });
}

app.whenReady().then(() => {
  createWindow();

  tray = new Tray(path.join(__dirname, 'icons/icon-24x24.png'));
  tray.setToolTip('WhatsLinux - Unofficial WhatsApp Client');
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('activate', () => {
  if (mainWindow === null) createWindow();
});
