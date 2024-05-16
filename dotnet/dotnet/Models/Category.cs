using System.ComponentModel.DataAnnotations;

namespace dotnet.Models
{
    public class Category
    {
        [Key]
        public int Id { get; set; }
        [Required]
        public string? Name { get; set; }
        public ICollection<Item>? Items { get; set; }
    }
}
