﻿using IfolorProducerService.Application.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IfolorProducerService.Core.Services
{
    public interface ISendService
    {
        Task SendToMessageBroker(SensorData sensorData);
    }
}
