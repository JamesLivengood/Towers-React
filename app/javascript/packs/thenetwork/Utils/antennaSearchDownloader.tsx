// import puppeteer from 'puppeteer';

// const antennaSearchDownloader = async () => {
//   const browser = await puppeteer.launch();

//   const page = await browser.newPage();

//   await page.goto('http://www.antennasearch.com/sitestart.asp?reportname001=antennacheck&raditem=002&reportname002=antennacheck&x=45&y=9&sourcepagename=SrchAnt&cmdRequest=process&latitude002=41.767804&longitude002=-74.077734');

//   await page.waitForSelector("[href*='/downloads_ant_free/Towers");

//   // console.log(await page.content());
//   await page.screenshot({ path: 'screenshot2.png' });

//   const towerLink = await page.evaluate(() => {
//     // console.log(document.);
//     // console.log(document.querySelectorAll("[href*='/downloads_ant_free/Towers")[0]);
//     // const transmitterLink = document.querySelectorAll("[href*='/downloads_ant_free/Transmitters")[0];
//     // console.log(towerLink.href);
//   });

//   // await page.goto(towerLink.href);


//   await browser.close();
// }

// export default antennaSearchDownloader;