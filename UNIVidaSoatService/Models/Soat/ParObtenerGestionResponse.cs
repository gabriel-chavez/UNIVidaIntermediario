using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UNIVidaSoatService.Models
{
    public class ParObtenerGestionResponse
    {
        public int Secuencial { get; set; }
        public DateTime VentaDesde { get; set; }
        public DateTime VentaHasta { get; set; }
        public int PrioridadVenta { get; set; }
    }
}
