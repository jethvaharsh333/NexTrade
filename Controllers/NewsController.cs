using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.WebUtilities;
using NexTrade.Service;
using System.Net.Http;

namespace NexTrade.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NewsController : ControllerBase
    {
        private readonly NewsService _newsService;

        public NewsController(NewsService newsService)
        {
            _newsService = newsService;
        }

        [AllowAnonymous]
        [HttpGet]
        public async Task<IActionResult> GetNews()
        {
            try
            {
                
                return Ok("res");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal Server Error: {ex.Message}");
            }
        }

        [AllowAnonymous]
        [HttpGet("{stockSymbol}")]
        public async Task<IActionResult> GetNewsByStocks(string stockSymbol)
        {
            try
            {
                var res = await _newsService.GetNewsByStocksService(stockSymbol);
                return Ok(res);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal Server Error: {ex.Message}");
            }
        }
    }
}

// gn5T7RfIPJteACH2dilxsDTVZ1DC4cFy0cZSQ9dq
/*
 * https://api.marketaux.com/v1/news/all?symbols=SBIN.NS&filter_entities=true&language=en&api_token=gn5T7RfIPJteACH2dilxsDTVZ1DC4cFy0cZSQ9dq
 */

//bf3694bdc62d4603b8cfe1a4eb59982f
//pub_72964fbd91d9bd32f255f3d1395e062dfc0b9
