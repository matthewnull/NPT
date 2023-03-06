namespace NPT
{
    internal class DropDownEntry
    {
        public int ID { get; set; }

        public string Name { get; set; }

        public DropDownEntry(int id, string name)
        {
            this.ID = id;
            this.Name = name;
        }
    }
}
