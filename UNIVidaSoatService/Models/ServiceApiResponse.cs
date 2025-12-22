namespace UNIVidaSoatService.Models
{
    public class ServiceApiResponse<T>
    {
        public int CodigoRetorno { get; set; }
        public bool Exito { get; set; }
        public string Mensaje { get; set; }
        public T oSDatos { get; set; }
    }

}
