using Newtonsoft.Json;
using System;
using System.Configuration;
using System.Net.Http;
using System.Text;
using UNIVidaSoatService.Models;

namespace UNIVidaSoatService.Services
{
    public class SoatApiClient
    {
        private readonly HttpClient _httpClient;

        public SoatApiClient()
        {
            string baseUrl = ConfigurationManager.AppSettings["SoatApiBaseUrl"];

            if (string.IsNullOrWhiteSpace(baseUrl))
                throw new Exception("La URL base del servicio SOAT no está configurada.");

            _httpClient = new HttpClient
            {
                BaseAddress = new Uri(baseUrl)
            };
        }

        public string ConsumirMetodo(ServiceApiRequest request)
        {
            string json = JsonConvert.SerializeObject(request);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            // POST sincrónico
            var response = _httpClient.PostAsync("api/ejecucion/consumirmetodo", content).Result;

            if (response.IsSuccessStatusCode)
            {
                return response.Content.ReadAsStringAsync().Result;
            }
            else
            {
                string error = response.Content.ReadAsStringAsync().Result;
                throw new Exception($"Error {response.StatusCode}: {error}");
            }
        }
    }
}
