using dotnet.Data;
using dotnet.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace dotnet.Controllers
{
    public class ItemsController : Controller
    {
        public ItemsController(AppDbContext db)
        {
            _db = db;
        }
        private readonly AppDbContext _db;
        public IActionResult Index()
        {
            IEnumerable<Item> itemsList = _db.items.Include(c => c.Category).ToList();
            return View(itemsList);
        }

        public IActionResult New()
        {
            createSelectList();
            return View();

        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult New(Item item)
        {
            if (ModelState.IsValid)
            {
                _db.Add(item);
                _db.SaveChanges();
                TempData["successData"] = "Item has been added successfully";
                return RedirectToAction("Index");
            }
            else
            {
                return View(item);
            }
            

        }

        public void createSelectList(int selectId = 1)
        {
            /* List<Category> categories = new List<Category> {
               new Category() {Id = 0, Name = "Select Category"},
               new Category() {Id = 1, Name = "Computers"},
               new Category() {Id = 2, Name = "Mobiles"},
               new Category() {Id = 3, Name = "Electric machines"},
             };*/

            List<Category> categories = _db.Categories.ToList();
            SelectList listItems = new SelectList(categories, "Id", "Name", selectId);
            ViewBag.CategoryList = listItems;

        }

        public IActionResult Edit(int? Id)
        {
            if (Id == null || Id == 0)
            {
                return NotFound();
            }
            var item = _db.items.Find(Id);
            if (item == null)
            {
                return NotFound();
            }
            createSelectList();
            return View(item);
        }

        //POST
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(Item item)
        {
           
            if (ModelState.IsValid)
            {
                _db.items.Update(item);
                _db.SaveChanges();
                TempData["successData"] = "Item has been updated successfully";
                return RedirectToAction("Index");
            }
            else
            {
                return View(item);
            }
        }

        public IActionResult Delete(int? Id)
        {
            if (Id == null || Id == 0)
            {
                return NotFound();
            }
            var item = _db.items.Find(Id);
            if (item == null)
            {
                return NotFound();
            }
            createSelectList();
            return View(item);
        }

        //POST
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteItem(int? Id)
        {
            var item = _db.items.Find(Id);
            if (item == null)
            {
                return NotFound();
            }
            _db.Remove(item);
            _db.SaveChanges();
            TempData["successData"] = "Item has been deleted successfully";
            return RedirectToAction("Index");
        }

    }
}
