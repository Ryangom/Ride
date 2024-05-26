import { Component, ViewChild } from '@angular/core';
import { Chart, registerables } from 'chart.js';
import { ngxCsv } from 'ngx-csv/ngx-csv';
import { ApplicationInfo } from 'src/app/model/ApplicationInfo.model';
import { AdminService } from 'src/app/service/admin.service';
Chart.register(...registerables);
@Component({
  selector: 'app-report',
  templateUrl: './report.component.html',
  styleUrls: ['./report.component.css']
})
export class ReportComponent {
  getObjectHeader: any;
  adminService: AdminService;
  applicationInfo: ApplicationInfo = new ApplicationInfo();
  constructor(adminService: AdminService) {
    this.adminService = adminService;
  }


  ngOnInit(): void {
    this.adminService.getApplicationInfo().subscribe((data) => {
      this.applicationInfo = data.data;
    })
    this.chart();
  }

  downloadReport(type: string) {
    this.adminService.adminDownoadUserReport(type).subscribe((data) => {
      this.getObjectHeader = Object.keys(data.data[0])

      let options = {
        fieldSeparator: ',',
        quoteStrings: '"',
        decimalseparator: '.',
        showLabels: true,
        showTitle: true,
        title: `${type} Report`,
        useBom: true,
        noDownload: false,
        headers: this.getObjectHeader
      };

      const csv = new ngxCsv(data.data, type + ' report', options);
    })

  }

  @ViewChild('chart') mychart: any;
  canvas: any;
  ctx: any;

  chart() {

    const chart = new Chart('chart', {
      type: 'bar',
      data: {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'July', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        datasets: [
          {
            label: 'Intercity Ride',

            backgroundColor: '#42A5F5',
            borderColor: '#1E88E5',

            data: [1, 20, 40, 0, 15,]

          },
          {
            label: 'Reugular Ride',
            backgroundColor: '#9CCC65',
            borderColor: '#7CB342',

            data: [4, 10, 20, 30, 41]

          }
        ]
      }

    });
    const pie = new Chart('pie', {
      type: 'line',
      data: {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'July', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        datasets: [
          {
            label: 'Intercity Ride',

            backgroundColor: '#42A5F5',
            borderColor: '#1E88E5',

            data: [1, 20, 40, 0, 15,]

          },
          {
            label: 'Reugular Ride',
            backgroundColor: '#9CCC65',
            borderColor: '#7CB342',

            data: [4, 10, 20, 30, 41]

          }
        ]
      }

    });


  }



}
