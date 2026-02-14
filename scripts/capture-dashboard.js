const { chromium } = require('playwright');
const path = require('path');

const BASE_URL = 'http://127.0.0.1:18789';
const TOKEN = process.argv[2];
const OUT_DIR = path.join(__dirname, '..', 'screenshots', 'dashboard');

const TABS = [
  { name: 'overview', path: '/' },
  { name: 'chat', path: '/chat' },
  { name: 'channels', path: '/channels' },
  { name: 'instances', path: '/instances' },
  { name: 'sessions', path: '/sessions' },
  { name: 'usage', path: '/usage' },
  { name: 'cron-jobs', path: '/cron-jobs' },
  { name: 'agents', path: '/agents' },
];

async function main() {
  if (!TOKEN) {
    console.error('Usage: node capture-dashboard.js <gateway-token>');
    process.exit(1);
  }

  const browser = await chromium.launch();
  const context = await browser.newContext({
    viewport: { width: 1280, height: 800 },
  });

  // 토큰 쿠키 또는 localStorage 설정
  const page = await context.newPage();

  // 먼저 토큰 인증 페이지 접근
  await page.goto(`${BASE_URL}/?token=${TOKEN}`, { waitUntil: 'networkidle' });
  await page.waitForTimeout(2000);

  for (const tab of TABS) {
    console.log(`Capturing ${tab.name}...`);
    await page.goto(`${BASE_URL}${tab.path}`, { waitUntil: 'networkidle' });
    await page.waitForTimeout(1500);

    await page.screenshot({
      path: path.join(OUT_DIR, `${tab.name}.png`),
      fullPage: false,
    });
    console.log(`  -> ${tab.name}.png saved`);
  }

  await browser.close();
  console.log('Done! All screenshots saved.');
}

main().catch(console.error);
