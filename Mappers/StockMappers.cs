using NexTrade.Dtos.Stock;
using NexTrade.Models;

namespace NexTrade.Mappers
{
    public static class StockMappers
    {
        public static StockDto ToStockDto(this StockModel stockModel)
        {
            return new StockDto
            {
                StockID = stockModel.StockID,
                StockName = stockModel.StockName,
                StockSymbol = stockModel.StockSymbol,
                StockImage = stockModel.StockImage,
                Industry = stockModel.Industry,
                DateOfListing = stockModel.DateOfListing,
                FaceValue = stockModel.FaceValue,
                Comments = stockModel.Comments.Select(c => c.ToCommentDto()).ToList()
            };
        }

        public static StockListDto ToStockListDto(this StockModel stockModel)
        {
            return new StockListDto
            {
                StockName = stockModel.StockName,
                StockSymbol = stockModel.StockSymbol,
                StockImage = stockModel.StockImage,
                Industry = stockModel.Industry,
                FaceValue = stockModel.FaceValue,
            };
        }

        public static StockModel ToStockFromRequestDto(this CreateStockRequestDto stockDto)
        {
            return new StockModel
            {
                StockName = stockDto.StockName,
                StockSymbol = stockDto.StockSymbol,
                StockImage = stockDto.StockImage,
                Industry = stockDto.Industry,
                DateOfListing = stockDto.DateOfListing,
                FaceValue = stockDto.FaceValue
            };
        }
    }
}
